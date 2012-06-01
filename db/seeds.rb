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
User.delete_all
Group.delete_all
Translation.delete_all

# require 'active_record/fixtures'
# Fixtures.create_fixtures("#{Rails.root}/db/fixtures", "language_i18ns")

#create users



#create groups


#user sign up groups



#import translations to db

#groups and users add translations


##create languages
german = Language.create(:name => "German", :iso_code => "de")
germande = Language.create(:name => "German(Germany)", :iso_code => "de-de")
germanat = Language.create(:name => "German(Austria)", :iso_code => "de-at")
germanch = Language.create(:name => "German(Switzerland)", :iso_code => "de-ch")
english = Language.create(:name => "English", :iso_code => "en")
englishus = Language.create(:name => "English(USA)", :iso_code => "en-us")
englishgb = Language.create(:name => "English(UK)", :iso_code => "en-gb")

##create domains
eleceng = Domain.create(:name => "Electrical Engineering", :code=> "ELECENG")
mechceng = Domain.create(:name => "Mechanical Engineering", :code=> "MECHENG")
gen = Domain.create(:name => "General German", :code=> "GENERAL")


#create some translations tied to languages and domains and users/groups
trans1 = Translation.create(:source_language_id => german, :source_content => "Das Auto ist rot", :target_content => "The car is red", :target_language_id => english)
context1 = Context.create(:translation_id => trans1, :domain_id => gen)
auser = User.create(:name => "Rom Reader")
agroup = Group.create(:name => "VW Tech Group")

auth1 = Authority.create(:authoritable_id => trans1, :authoritable_id => auser)