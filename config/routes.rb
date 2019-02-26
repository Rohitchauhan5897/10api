Rails.application.routes.draw do
	post "first/create_user" => "first#create_user" 
	post "first/login" => "first#login"
	get  "first/destroy/token/:token" => "first#destroy"
	post "first/updateprofile" => "first#updateprofile"
	post "first/changepassword" => "first#changepassword"
	post "first/forgetpassword" => "first#forgetpassword"
	post "first/resetpassword" => "first#resetpassword"
	post "first/login_with_social" => "first#login_with_social"
end
