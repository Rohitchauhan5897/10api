class FirstController < ApplicationController



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


end
