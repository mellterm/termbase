class Context < ActiveRecord::Base
  attr_accessible :domain_id, :translation_id
  
  belongs_to :translation
  belongs_to :domain
  
end
#--
# generated by 'annotated-rails' gem, please do not remove this line and content below, instead use `bundle exec annotate-rails -d` command
#++
# Table name: contexts
#
# * id             :integer         not null
#   translation_id :integer
#   domain_id      :integer
#   created_at     :datetime        not null
#   updated_at     :datetime        not null
#--
# generated by 'annotated-rails' gem, please do not remove this line and content above, instead use `bundle exec annotate-rails -d` command
#++
