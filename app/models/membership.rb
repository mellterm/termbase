class Membership < ActiveRecord::Base
  attr_accessible :created_on, :expired, :expires_on, :group_id, :user_id
  
  belongs_to :user
  belongs_to :group
  
end