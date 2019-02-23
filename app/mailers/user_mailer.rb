class UserMailer < ApplicationMailer
	def send_otp(otp,email)
		@email=email
		@otp=otp
		 mail(to: @email, subject: 'mail sent successfully')
	end	
end
