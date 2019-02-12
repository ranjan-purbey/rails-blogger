class User < ApplicationRecord
  has_many :blogs, dependent: :destroy
  before_save {self.username = username.downcase}
  validates :username, length: {minimum: 5}, uniqueness: {case_sensitive: false}
  validates :password, length: {in: 8..20}
  has_secure_password
end
