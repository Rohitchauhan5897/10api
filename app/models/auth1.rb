class Auth1 < ApplicationRecord
  belongs_to :user1
  has_many :session1s
  has_secure_password
end
