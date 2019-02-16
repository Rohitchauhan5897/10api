class Auth1 < ApplicationRecord
  belongs_to :user1
  has_many :session
  has_secure_password
end
