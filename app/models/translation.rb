class Translation < ActiveRecord::Base
  acts_as_versioned :table_name => :translation_versions
  
  serialize :metadata
    
  TRANSLATION_ILKS = ['Segment', 'Term']
  validates :ilk, :inclusion => TRANSLATION_ILKS
  
  validates_uniqueness_of :source_content, :scope => [:target_content, :authority_id], :unless => :domain_different
  
  def domain_different
    #return true if domain different
    return false
  end
  

  
  attr_protected :version
  attr_accessible :type, :source_language_id, :source_content, :target_language_id, :target_content, :contexts_attributes, :metadata, :authority_id, :ilk
  scope :rough_search, lambda {|query| where("source_content like ?", "%#{query}%").order(:updated_at) }
  scope :exact_search, lambda {|query| where("source_content = ?", "#{query}").order(:updated_at) }

  has_many :comments, :as => :commentable
  has_many :ratings, :as => :ratable
  
  has_one :created_by, :class_name => "User"
  
  belongs_to :group
  
  has_many :associations, :foreign_key => "associator_id"
  has_many :associateds, :through => :associations, :source => :associated
  
  
  
  has_many :contexts
  has_many :domains, :through => :contexts
  
  
  accepts_nested_attributes_for :contexts
  
  #allows for quick entry of terms by copying languages, type (seg, term), authority id
  def copy
    self.class.new.tap do |new_trans|
      attributes.each do |key,value|
        new_trans.send("#{key}=", value) unless key == "id"
      end
        new_trans.save
    end
  end
  
  
end
#--
# generated by 'annotated-rails' gem, please do not remove this line and content below, instead use `bundle exec annotate-rails -d` command
#++
# Table name: translation_versions
#
# * id                 :integer         not null
#   translation_id     :integer
#   version            :integer
#   source_language_id :integer
#   source_content     :string(255)
#   target_language_id :integer
#   target_content     :string(255)
#   created_by_id      :integer
#   group_id           :integer
#   metadata           :text
#   ilk                :string(255)     default Term
#   created_at         :datetime
#   updated_at         :datetime
#   versioned_type     :string(255)
#
#  Indexes:
#   index_translation_versions_on_translation_id  translation_id
#--
# generated by 'annotated-rails' gem, please do not remove this line and content above, instead use `bundle exec annotate-rails -d` command
#++
