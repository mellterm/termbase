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

require 'active_record/fixtures'
# languages will be from a language file?? #see ascii 179
ActiveRecord::Fixtures.create_fixtures("#{Rails.root}/db/fixtures", "languages")
ActiveRecord::Fixtures.create_fixtures("#{Rails.root}/db/fixtures", "domains")
#domains will be from a CSV?


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