class Auth1 < ApplicationRecord
  belongs_to :user1
  has_many :session
  has_secure_password


	 # def as_json()
	 # 	as_json()
	 # end

end
