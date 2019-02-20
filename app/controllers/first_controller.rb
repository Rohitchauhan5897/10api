class FirstController < ApplicationController
before_action  :current_user , except: [:create_user,:login]

	def create_user
		@user1 =get_user(params[:email])
        	@user2 =get_user2(params[:username])
       	if !@user1.present? && !@user2.present?
        		  user =User1.create!(firstname:params[:firstname], lastname:params[:lastname], username:params[:username],email:params[:email], contact_no: params[:contact_no], gender:params[:gender], dob:params[:dob])
           		  if user.present?
           			Auth1.create!(password:params[:password],user1_id: user.id)	
              		render json:{code:200, message: "User Signed Up Successfully!", user:user}
        		   else
        			render json:{code:500, message: "Bad Request!!"}
  			   end
            else
         		   render json:{code:400, message: "User already exists in the database!"}
	    	end
	end

	def login
		userinfo = get_user_details(params[:email],params[:email])
		auth = userinfo.present? ? userinfo.first.auth1 : false
		if userinfo.present? && auth.authenticate(params[:password])
			@temp = SecureRandom.hex
			#if !temp.present?
				@session = Session1.create!(token:@temp,auth1_id:auth.id)
				render json:{code:200,message:"logged in successfully", user:user_method(userinfo.first,@temp)}
			#end
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

		# p token.auth1.user1
		if userinfo.present?
			userinfo.update(firstname:params[:firstname], lastname:params[:lastname], contact_no:params[:contact_no],gender:params[:gender],dob:params[:dob])
			render json:{code:200,message:"Profile Update successfully", user:user_method(userinfo,@token.token)}
      	 else
       		render json:{code:400,message:"Profile not Update"}	
		end 
	end
end



			 