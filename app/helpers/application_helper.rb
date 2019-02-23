module ApplicationHelper
	include FirstHelper

	def send_json_method code,message
		render json:{code:code,message:message}
	end
end
