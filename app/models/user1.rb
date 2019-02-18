class User1 < ApplicationRecord
	has_one :auth1
	validates :firstname, presence: true
	validates :lastname, presence: true
	validates :username, presence: true
	validates :email, presence: true
	validates :contact_no, presence: true
	validates :gender, presence: true
	validates :dob, presence: true

	def self.take_email email
  		 find_by_email(email)
  	end
  	

  	def self.take_username username
  		find_by_username(username)
    end


	def self.find_email_or_username email,username
		where("email = ? or username = ?",email,username)
	end

end
