class User1 < ApplicationRecord
	has_one :auth1
	has_many :socialauths
	validates :firstname, presence: true
	validates :lastname, presence: true
	validates :username, presence: true
	validates :email, presence: true
	validates :contact_no, presence: true 
	validates :gender, presence: true
	validates :dob, presence: true

	# def as_json()
	# 	as_json()
	# end

	def self.take_email email
  		 find_by_email(email)
  	end
  	

  	def self.take_username username
  		find_by_username(username)
    end


	def self.find_email_or_username email,username
		where("email = ? or username = ?",email,username)
	end

	 # def self.find_user_by_email_or_contact email,contact_no
	 # 	where("email = ? or contact_no = ?",email,contact_no)
	 # end

	def self.as_json()
		as_json()
	end	
	
	def self.generate_social_user provider_type,provider_id,firstname,lastname,username,email,contact_no,gender,dob,url
		# begin
		pwd=(SecureRandom.random_number(9e5) + 1e5).to_i
		token=SecureRandom.hex
		social_user = new(firstname:firstname,lastname:lastname,username:username,email:email,contact_no:contact_no,gender:gender,dob:dob,secure_url:url)
		social_user.save
		if social_user.present?
			user_id=social_user.id
			auth=Auth1.create(user1_id:user_id,password_digest:pwd)
			if auth
				auth_id=auth.id
				session=Session1.create(auth1_id:auth_id,token:token)
				if session 
					Socialauth.create(user1_id:social_user.id,provider_type:provider_type,provider_id:provider_id)
					social_user
				end
			end
		end
		# rescue Exception => e
	 #    render json:{code:401,message: "#{e}"}
	end
end
