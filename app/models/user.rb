require 'digest'
class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :activation_code, :acticated_at
  attr_accessor :password

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, :presence => true,
                   :length   => { :maximum => 30 }
  validates :email, :presence => true,
                   :format   => { :with => email_regex },
                   :uniqueness => { :case_sensitive => false }
  validates :password, :presence      => true,
                       :confirmation  => true,
                       :length        => { :within => 6..30 }

  before_save :encrypt_password

  before_create :make_activation_code
  # Return true if the user's password matches the submitted password
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    user && user.has_password?(submitted_password) ? user : nil
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end
 
  def send_new_password
    new_pass = User.random_string(10)
    self.password = self.password_confirmation = new_pass
    self.save
    Notifications.deliver_forgot_password(self.email, self.login, new_pass)
  end
  
  def make_activation_code
    self.activation_code = Digest::SHA2.hexdigest(Time.now.to_s.split(//).sort_by{rand}.join)
  end

  def send_activate
    Notifier.activate(self).deliver
  end

  def activate
    self.update_attributes(:activation_code => nil, :activated_at => Time.now)
  end

  def activated?
    activation_code.nil?
  end

  private
    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password) if password != nil && !password.blank?
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

    def self.random_string(len)
      #generate a random password consisting of strings and digits
      chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
      newpass = ""
      1.upto(len){ |i| newpass << chars[rand(chars.size-1)] }
      return newpass
    end

end

# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

