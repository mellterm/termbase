class User < ActiveRecord::Base
  attr_accessible :name, :subscribed
  
  
  #predefined queries
  scope :by_name, order(:name)
  scope :subscribed, where(:subscribed => true) 
  
  
  has_many :memberships
  has_many :groups, :through => :memberships
  
  has_many :former_groups, :through => :memberships, :source => :group, :conditions => [:expired => true]
  
  
  has_many :authorities, :as => :authoritable
end
