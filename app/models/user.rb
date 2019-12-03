require 'bcrypt'
class User < ApplicationRecord
  validates_confirmation_of :password
  has_secure_password

  def authenticate(plaintext_password)
    BCrypt::Password.new(self.password_digest) == plaintext_password
  end
end