class Session1 < ApplicationRecord
  belongs_to :auth1
  
  def self.find_token token
  		find_by_token(token)
    end
end
