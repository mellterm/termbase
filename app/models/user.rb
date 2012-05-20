class User < ActiveRecord::Base
  attr_accessible :name, :subscribed
end
