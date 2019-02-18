Rails.application.routes.draw do
	post "first/create_user" => "first#create_user" 
	post "first/login" => "first#login"
	get  "first/destroy/token/:token" => "first#destroy"
	post "first/updateprofile/:id" => "first#updateprofile"
end
