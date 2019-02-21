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

		def user_method userinfo,temp
			userinfo.as_json.merge(token:temp)
		end
end
