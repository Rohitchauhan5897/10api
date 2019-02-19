class Auth < ApplicationRecord
  belongs_to :user
  has_secure_password
end
