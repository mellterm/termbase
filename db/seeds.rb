# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#delte everything and reseed
Language.delete_all
Domain.delete_all
# User.delete_all
# Group.delete_all
# Translation.delete_all
Badge.delete_all
RegEx.delete_all

require 'active_record/fixtures'
# languages will be from a language file?? #see ascii 179
ActiveRecord::Fixtures.create_fixtures("#{Rails.root}/db/fixtures", "languages")
ActiveRecord::Fixtures.create_fixtures("#{Rails.root}/db/fixtures", "domains")


#create regexes
RegEx.create!(
    :id => 1,
    :language_id => 21,
    :regex_category => "phone",
    :expression => "^([\+][0-9]{1,3}[ \.\-])?([\(]{1}[0-9]{1,6}[\)])?([0-9 \.\-\/]{3,20})((x|ext|extension)[ ]?[0-9]{1,4})?$"
  )
RegEx.create!(
      :id => 2,
      :language_id => 26,
      :regex_category => "phone",
      :expression => "(([0-9]{3})|((\()([0-9]{3})(\))))?([\s\.-])?([0-9]{3})([\s\.-])?([0-9]{4})([\s\.-])?([x] ?[0-9]{1,7})?"
)
    
    RegEx.create!(
        :id => 3,
        :language_id => 1000,
        :regex_category => "singleton_digitsalphasdigits_digits",
        :expression => "^\d+[\w|\d]*_\d*$"
      )
      
RegEx.create!(
          :id => 4,
          :language_id => 1000,
          :regex_category => "singleton_alphas_digits",
          :expression => "^\w*_\d*$"
)
      
        RegEx.create!(
            :id => 5,
            :language_id => 1000,
            :regex_category => "singelton_alpha_alphas_alphas",
            :expression => "^\w+_[a-z]+_\w+$"
)
          
RegEx.create!(
              :id => 6,
              :language_id => 1000,
              :regex_category => "ALPHASDIGITS",
              :expression => "^[A-Z]+\d$"
)  
          
          

#create badges
fact = Badge.create!(:name => "Factotum")
trans = Badge.create!(:name => "Translator")
proof = Badge.create!(:name => "Proofreader")
#these badges are assigned not assignable
rockstar = Badge.create!(:name => "Rockstar Translator")

#create users



#create profiles

#create groups


#user sign up groups



#import translations to db

#groups and users add translations


#create some translations tied to languages and domains and users/groups
# trans1 = Translation.create(:source_language_id => german, :source_content => "Das Auto ist rot", :target_content => "The car is red", :target_language_id => english)
# context1 = Context.create(:translation_id => trans1, :domain_id => gen)
# auser = User.create(:name => "Rom Reader")
# agroup = Group.create(:name => "VW Tech Group")
# 
# auth1 = Authority.create(:authoritable_id => trans1, :authoritable_id => auser)