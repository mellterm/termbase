class Group < ActiveRecord::Base
  attr_accessible :type, :name
  
  has_many :memberships
  has_many :users, :through => :memberships
  
  has_many :authorities, :as => :authoritable
  
end
