class Translation < ActiveRecord::Base
  acts_as_versioned :table_name => :translation_versions
  #types
  TRANSLATION_TYPES = ['Segment', 'Term']
  
  attr_accessible :source_content, :source_language_id, :target_language_id, :type, :version, :target_content

  scope :rough_search, lambda {|query| where("source_content like ?", "%#{query}%").order(:updated_at) }
  scope :exact_search, lambda {|query| where("source_content = ?", "#{query}").order(:updated_at) }

  has_many :comments, :as => :commentable
  has_many :ratings, :as => :ratable
  
  has_many :associations
  has_many :associates, :through => :associations, :source => :associate
  
  
  
  
end
