class Translation < ActiveRecord::Base
  
  #types
  TRANSLATION_TYPES = ['Segment', 'Term']
  
  attr_accessible :source_content, :source_language_id, :target_language_id, :type, :version
end
