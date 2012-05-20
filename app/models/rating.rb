class Rating < ActiveRecord::Base
  attr_accessible :ratable_id, :ratable_type, :score
  
  belongs_to :ratable, :polymorphic => true
  
end
