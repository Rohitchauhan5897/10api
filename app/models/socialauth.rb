class Socialauth < ApplicationRecord
  belongs_to :user1

  def self.create_social_user user,device_type,device_id,authinfo
  		@token = SecureRandom.hex
  		user=new(user1_id:user.id,device_type:device_type,device_id:device_id)
		user.save!
		if user.present?
			Session1.create(auth1_id:authinfo.id,token:@token)
  		end
  end

end
