$userinfo
class FirstController < ApplicationController
before_action  :current_user , except: [:create_user,:login]

	def create_user
								 # begin					 	
									@user1 =get_user(params[:email])
        	@user2 =get_user2(params[:username])
       					if !@user1.present? && !@user2.present?
       							 result = Cloudinary::Uploader.upload(params[:image])
       							 # p "================="
       							 # p result["secure_url"]
        		  			user =User1.create!(firstname:params[:firstname], lastname:params[:lastname], username:params[:username],email:params[:email], contact_no: params[:contact_no], gender:params[:gender], dob:params[:dob],secure_url:result["secure_url"],image:params[:image])
           		  		if user.present?
           									info=Auth1.create!(password:params[:password],user1_id: user.id)	
              						render json:{code:200, message: "User Signed Up Successfully!", user:user.as_json(only:[:firstname,:lastname,:username,:email,:contact_no,:gender,:dob,:secure_url])}
        		   				else
        												render json:{code:500, message: "Bad Request!!"}
  			   								end
        				else
         		   render json:{code:400, message: "User already exists in the database!"}
	    						end
	    	# rescue Exception => e
	    	# 	render json:{code:401,message: "#{e}"}
    		# end
	end

	def login
										$userinfo = get_user_details(params[:email],params[:email])
										auth = $userinfo.present? ? $userinfo.first.auth1 : false
										if $userinfo.present? && auth.authenticate(params[:password])
														@temp = SecureRandom.hex
														@session = Session1.create!(token:@temp,auth1_id:auth.id)
														render json:{code:200,message:"logged in successfully", user:user_method($userinfo.first,@temp)}												
										else
		   						 		render json:{code:400,message:"Enter Correct Username or Password"}	
										end	    
	end

	def destroy
								 	token = Session1.find_by_token(params[:token])
	 								if token.present?
   	   										token.destroy
	 	   											render json:{code:200, message: "The user has been succesfully Logout..!"}
	 								else
	 	 													render json:{code:400, message: "Id not found"}
  								end	
	end

	def updateprofile
										@token=Session1.find_by_token(params[:token])
										userinfo = @token.present? ? @token.auth1.user1 : nil
										if userinfo.present?
											     if !params[:image].present?

																	userinfo.update(firstname:params[:firstname], lastname:params[:lastname], contact_no:params[:contact_no],gender:params[:gender],dob:params[:dob])
																	render json:{code:200,message:"Profile Update successfully", user:user_method(userinfo,@token.token)}
      	 								else
      	 									result = Cloudinary::Uploader.upload(params[:image])
      	 										userinfo.update(firstname:params[:firstname], lastname:params[:lastname], contact_no:params[:contact_no],gender:params[:gender],dob:params[:dob],secure_url:result["secure_url"],image:params[:image])
																	render json:{code:200,message:"Profile Update successfully", user:user_method(userinfo,@token.token)}
      	 								end
      	 		else
       										render json:{code:400,message:"Profile not Update"}	
										end 
	end

	def changepassword 
								usertoken = Session1.find_by_token(params[:token])
								# p $userinfo
								# password = $userinfo.present? ? $userinfo.first.auth1 : nil
								password = usertoken.auth1
		 					authenticate =password.authenticate(params[:old_password])		
		 if authenticate.present? && usertoken.present?
		 	 			authenticate.update(password:params[:new_password])
								render json:{code:200,message:"Password Update successfully",user:user_method(authenticate.as_json(only:[:id]),usertoken.token)}
			else
								render json:{code:400,message:"Password Does not Update successfully"}
			end
	end

	def forgetpassword
							# begin
							if params[:email].present?
											user = get_user(params[:email])
														if !user.present?
																	send_json_method(404,"User does not exists!")
														else
																		auth	= Auth1.find_by(user1_id:user.id) 
																		@otp=(SecureRandom.random_number(9e5) + 1e5).to_i
																		auth.update(otp:@otp)
																		UserMailer.send_otp(@otp,user.email).deliver_now
																		send_json_method(200,"OTP has been sent successfully")
														end
							else
											send_json_method(400,"Parameter required!")
							end
	end

	def resetpassword
						begin
						auth = Auth1.find_by_otp(params[:otp])
									if auth.present?
													change_password = auth.update(password:params[:new_password])
													render json:{code:200,message:"password has been updated successfully"}
									else
													render json:{code:400, message: "Sorry you entered the wrong OTP,try again..!"}
									end
													rescue Exception => e
													render json:{code:401,message: "#{e}"}
						end
	end
	
	def login_with_social
		if (params[:firstname].present? && params[:lastname].present? && params[:username].present? && params[:email].present? && params[:contact_no].present? && params[:gender].present? && params[:dob].present?)
				 if params[:email].present?	
							user = get_user(params[:email]) 
							if user.present? && user.valid?
										authinfo = user.auth1
					 				create_social_auth(user,params[:device_type],params[:device_id],authinfo)					 													
										render json:{code:200,message:"login Successful",user:user}
							else 	
									 result = Cloudinary::Uploader.upload(params[:image])
									 url = result["secure_url"]
										social_user = create_user_with_signup(params[:device_type],params[:device_id],params[:firstname],params[:lastname],params[:username],params[:email],params[:contact_no],params[:gender],params[:dob],url,params[:image])
										render json:{code:200,message:"login Successful",user:social_user.as_json(only:[:firstname,:lastname,:username,:email,:gender,:contact_no,:dob,:secure_url])}
							end
					else
									render json:{code:400,message:"Email con not be blank"}
					end
			else
										render json:{code:400,message:"Field can't be blank"}
			end
	end
end