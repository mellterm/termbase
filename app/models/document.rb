class Document < ActiveRecord::Base
  attr_accessible :name, :url, :owner_id, :data, :id, :domains_attributes
  
  has_attached_file :data
  before_post_process :set_content_type
  has_many :translations
  
  has_one :owner, :class_name => 'User'

  has_many :domains
  
  accepts_nested_attributes_for :domains
  
  after_save :process_file
  #NEED Purpose/Type
  #document processing PDF or Word --> CV. Attach to User Profile
  #  TMX
  #  Plain Text
  
  #SPLIT into segments (Translations)
  
  
  #  CSV 
  #  google docs?? 
  def is_csv?
      self.data_file_name.match("(\.csv)$")
  end
  
  
  def set_content_type
    self.data.instance_write(:content_type, MIME::Types.type_for(self.data_file_name).to_s)
  end
  
  
  def what_type
      mime_tye = self.data_content_type
      file_path = self.data.path
      if file_path.match("(\.tmx)$")
            Rails.logger.info("[file] #{file_path} is TMX")
            return 'TMX'
      end
  end
  
   #  
   
  
  def process_file
    
      ### TYPE CHECKS ####
      # @todo Do type checks to distinguish between TMX< CSV, and non-supported files
     
      # if what_type == 'TMX' type.should be 'TMX'
      
           #what is a valid TMX document?
           # header.get_attribute('datatype') != 'xml' 
           # if header.get_attribute('o-tmf') != 'SDL TM8 Format' and header.get_attribute('o-tmf') != 'TW4Win 2.0 Format'       
           #     Rails.logger.info("[file] #{self.data.path} is not a TMX")
           #    return false
           #  else
      
      
      ###CHECK PASSED
      
         require 'nokogiri'
         require 'open-uri'
         
      ###FILE HANDLING AND XML   
         
         f = File.open(self.data.path)
         #doc is Nokogiri::XML::Document
         doc = Nokogiri::XML(f)
         f.close
         
      ###NOKOGIRI
      
         #doc.xpath returns a Nodeset, .first is a Node (only one node in xpath expression header)
         header = doc.xpath('//header').first
               #get possibly useful header data: *creationid, *date
               
               if header.attributes['creationdate']
                creationdate = header['creationdate']
               end   
               if header.attributes['creationid']
                 creationdate = header['creationid']
               end 
               
              ##SET UP DATA FOR ALL TRANSLATIONS
                  # Nokogiri::XML::NodeSet tuvs (all tuvs)
                  # Nokogiri::XML::Element tuvs.first
               
               tuv1 = doc.xpath('//body//tu//tuv').first
               from_lang = tuv1['lang'].downcase
               to_lang = tuv1.next_element['lang'].downcase
               
               #if language not in table reject segment (language(s) not supported) - taken care of below
               #only do for first segment
               @source_language = Language.find_by_iso_code(from_lang)
               @target_language = Language.find_by_iso_code(to_lang)
               @exp_uns = RegEx.find_all_by_language_id(1000)
               
               
               ##PREPARING ITERATION
               
                 tus = doc.xpath('//body//tu')
                 total_tus= tus.count
                 rejected= 0   
                 terms =  0
                 segments = 0
                 fixedtime = Time.now+5.minute
                 seqno = 1                  
                 allvalues = Array.new
                 
              
                   
                tus.each do |tu|
                        #header data, may be useful for ranking
                        if tu.attributes['lastusagedate']
                             lastusagedate = tu['lastusagedate']
                        end
                        if tu.attributes['usagecount']
                              lastusagedate = tu['usagecount']
                        end
                   
                        #segs is a nodeset comprising 2 segs 
                        segs = tu.search('seg')  
                        if segs.size() == 2
                            source_content  = segs[0].child.content
                            source_content = source_content.chomp.strip.squeeze("  ")
                            target_content  = segs[1].child.content
                            target_content = target_content.chomp.strip.squeeze("  ")
                        end
              
                    unicode_mappings = { 'de' => {  
                                                "U+00FC"=> "uumlaut",
                                                "U+00F6"=> "oumlaut",
                                                "U+00e4"=> "aumulat",
                                                "U+00df"=> "sz"
                                                }
                                      }
                          def is_term(s)
                              if s.downcase.match("^[a-z\u00f6\u00df\u00a4\00fc]+$") and s.length >3
                                    
                                    return true
                              else
                                    return false
                              end
                          end  
                 
                          if is_term(source_content) and is_term(target_content)
                               ilk = 'Term'
                               terms +=1
                               # logger.debug "[tmx] #{from_lang} -> #{source_content} -> #{ilk}"
                               #                           logger.debug "======" 
                          else
                              segments +=1
                              ilk = 'Segment'
                          end
                    
                          #compress terms, chomp and chop
                          #see above 
                    
                          #fix language issue - back to XML :(
                          #do this Quicker!
                          #think about indexing of terms 
                    
                   
                          #ADD (DOCNAME)+_SEQNO    
                    
                   
                    
                    
                    allvalues.push(
                        [ source_content,
                          target_content,
                          @source_language.id,
                          @target_language.id,
                          self.id,
                          self.owner_id,
                          ilk,
                          fixedtime,
                          seqno.to_s
                          ]
                    
                    )
                    seqno+=1
            
                    
                    #domains afterwards
                    
                                      
                    ## source_content as is
                    ## send source_content to parser later , first remove tags
                     
                    #also update to include type....get type from TMX header data is optional?
                    #create Translation objects
                
                    logger.debug "[tmx] #{@source_language.id} -> #{source_content}"
                    logger.debug "[tmx] #{@target_language.id} -> #{target_content}"
                    logger.debug "======"
                    
               end
              
               
              ##ACTIVERECORD IMPORT GEM OPTION "Import Using Columns and Arrays" 
              columns = [ :source_content, :target_content, :source_language_id, :target_language_id, :document_id, :created_by_id,
                        :ilk, :created_at, :metadata ]
              values = allvalues 
              
              Translation.import columns, values, :validate => false
      
              logger.debug("Original count: #{total_tus}")
              logger.debug("==============")
              logger.debug("Segments: #{segments}")
              logger.debug("==============")
              logger.debug("Terms: #{terms}")
              
  end  #processfile  
      
      # # If File is a zip file
      #                if self.data.path.match("(\.zip)$") && mime_type.match("zip")
      #                    Rails.logger.info("[file] File is ZIP")
      #                    file_list = unzip_files
      #                    file_list.each do |file|
      #                      # process each file inside the zip file.
      #                      new_file = convert_once_to_utf8(file) #TODO???
      #                      import_processed_file(new_file)
      #                    end
      #                  return true
      #           
      #                # If extension is CSV
      #                if file_path.match("(\.csv)$")
      #                  Rails.logger.info("[file] #{file_path} is CSV")
      #                  import_csv
      #                  return true
      #                else
      #                  # Import the files if we have a file object
      #                  import_processed_file(file_path)
      #                end
      #              end
      #           
            # logger.debug "[tmx] #{from_lang} -> #{source_content}"
            # logger.debug "[tmx] #{to_lang} -> #{target_content}"
            # logger.debug "======"
            
            #language code for non language
            #UN = 1000
           
            # def is_junk(s, language)
            #         @exp_uns.each do |re|
            #          if s.match(re.expression)
            #            return true
            #          end
            #      end    
            #  end    
               #if still here, do language specific 
                                  # exps = RegEx.find_all_by_language_id(language)
                                  #               exps.each do |e|
                                  #                 if segment.match(e.expression)
                                  #                    return true
                                  #                 else
                                  #                   return false    
                                  #                end
               
    
            
            
            #filter out useless data
            # if is_junk(source_content, source_language) or is_junk(target_content, target_language) then
            #                     rejected +=1
            #                     next
            #                   end 
            
            # if (is_junk(source_content, source_language) or is_junk(target_content, target_language))
            #               rejected +=1
            #               next
            #         end
             
            #extract useful terms FIRST
  
  
end
#--
# generated by 'annotated-rails' gem, please do not remove this line and content below, instead use `bundle exec annotate-rails -d` command
#++
# Table name: documents
#
# * id                 :integer         not null
#   name               :string(255)
#   url                :string(255)
#   owner_id           :integer
#   data_file_name     :string(255)
#   data_content_type  :string(255)
#   data_file_size     :integer
#   data_updated_at    :datetime
#   source_language_id :integer
#--
# generated by 'annotated-rails' gem, please do not remove this line and content above, instead use `bundle exec annotate-rails -d` command
#++
