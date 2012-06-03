class Profile < ActiveRecord::Base
  attr_accessible :real_name, :birthday, :native_language_id, :bio, :location_id, :badge_id, :user_id
end
#--
# generated by 'annotated-rails' gem, please do not remove this line and content below, instead use `bundle exec annotate-rails -d` command
#++
# Table name: profiles
#
# * id                 :integer         not null
#   real_name          :string(255)     not null
#   birthday           :date
#   native_language_id :integer         not null
#   bio                :text
#   badge_id           :integer         not null
#   location_id        :integer
#   user_id            :integer         not null
#   created_at         :datetime        not null
#   updated_at         :datetime        not null
#
#  Indexes:
#   user_badge_unique_index  user_id,badge_id  unique
#--
# generated by 'annotated-rails' gem, please do not remove this line and content above, instead use `bundle exec annotate-rails -d` command
#++
