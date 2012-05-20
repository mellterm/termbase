class Authority < ActiveRecord::Base
  attr_accessible :authoritable_id, :authoritable_type
  
  belongs_to :authoritable, :polymorphic => true
  
end
