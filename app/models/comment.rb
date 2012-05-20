class Comment < ActiveRecord::Base
  attr_accessible :commentable_id, :commentable_type, :name
  
  belongs_to :commentable, :polymorphic => true
  
end
