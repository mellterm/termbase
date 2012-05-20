class Translation < ActiveRecord::Base
  
  #types
  TRANSLATION_TYPES = ['Segment', 'Term']
  
  attr_accessible :source_content, :source_language_id, :target_language_id, :type, :version, :target_content

  scope :rough_search, lambda {|query| where("source_content like ?", "%#{query}%").order(:updated_at) }
  scope :exact_search, lambda {|query| where("source_content = ?", "#{query}").order(:updated_at) }

  has_many :comments, :as => :commentable
  has_many :ratings, :as => :ratable

end
