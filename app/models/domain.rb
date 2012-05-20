class Domain < ActiveRecord::Base
  attr_accessible :code, :name
  
  has_many :contexts
  has_many :translations, :through => :contexts
  
end
