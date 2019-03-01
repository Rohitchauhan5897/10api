module FirstHelper

		def get_user email
		User1.take_email(email)
		end

		def get_user2 username
		User1.take_username(username)
		end

		def get_user_details email,username
		User1.find_email_or_username(email,username)
		end

		def get_logintoken token
		Session1.find_token(token)
		end

		def login
		session[:auth1_id]=@temp
		end

		 # def get_social_user_detail email,contact_no
		 #  	User1.find_user_by_email_or_contact(email,contact_no)
		 # end


		def user_method userinfo,temp
			userinfo.as_json.merge(token:temp)
		end

		def create_social_auth user,provider_type,provider_id,authinfo
		 Socialauth.create_social_user(user,provider_type,provider_id,authinfo)
    	end

    	# def create_social_session token,auth1_id
    	# Session1.create_social_session(token,auth1_id)
    	# end
    	def create_user_with_signup provider_type,provider_id,firstname,lastname,username,email,contact_no,gender,dob,url
    		User1.generate_social_user(provider_type,provider_id,firstname,lastname,username,email,contact_no,gender,dob,url)
    	end
end
