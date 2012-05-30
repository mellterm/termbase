class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  attr_accessor :password
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates     :email, :presence => true,
                :format => { :with => email_regex },
                :length => { :maximum => 50 },
                :uniqueness => {:case_sensitive => false }
  # validates     :password, :presence => true,
  #                 :confirmation => true,
  #                 :length => { :within => 6..40 }
  validates_presence_of :password, :on => :create
  
  before_save :encrypt_password
  before_create { generate_token(:auth_token) }
  
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end
  
  
  #using cookies not sessions
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  
  
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end
  
  private
  
  
     def encrypt_password
       self.salt = make_salt if new_record?
       self.encrypted_password = encrypt(password)
     end
     
     def encrypt(string)
       secure_hash("#{salt}--#{string}")
     end
     
     def make_salt
       secure_hash("#{Time.now.utc}--#{password}")
     end
     
     def secure_hash(string)
       Digest::SHA2.hexdigest(string)
     end
  
  
  #predefined queries
  scope :by_name, order(:name)
  scope :subscribed, where(:subscribed => true) 
  
  has_many :translations, :as  => 'Owner'
  
  has_many :memberships
  has_many :groups, :through => :memberships
  
  has_many :former_groups, :through => :memberships, :source => :group, :conditions => [:expired => true]
  
  
  has_many :authorities, :as => :authoritable
end
#--
# generated by 'annotated-rails' gem, please do not remove this line and content below, instead use `bundle exec annotate-rails -d` command
#++
# Table name: users
#
# * id                     :integer         not null
#   name                   :string(255)
#   subscribed             :boolean
#   created_at             :datetime        not null
#   updated_at             :datetime        not null
#   email                  :string(255)
#   encrypted_password     :string(255)
#   salt                   :string(255)
#   auth_token             :string(255)
#   password_reset_token   :string(255)
#   password_reset_sent_at :datetime
#
#  Indexes:
#   index_users_on_email  email  unique
#--
# generated by 'annotated-rails' gem, please do not remove this line and content above, instead use `bundle exec annotate-rails -d` command
#++
