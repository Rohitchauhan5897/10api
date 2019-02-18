class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  include ApplicationHelper

  def current_user
	 @current_user ||= Session1.find_by_id(session[:auth1_id])
	 if @current_user.present?
		 @current_user
	 else
	 	@current_user = nil
	 end
	 
   end
end
