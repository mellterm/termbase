class Context < ActiveRecord::Base
  attr_accessible :domain_id, :translation_id
  
  belongs_to :translation
  belongs_to :domain
end
