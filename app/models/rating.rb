class Rating < ActiveRecord::Base
  attr_accessible :ratable_id, :ratable_type, :score
end
