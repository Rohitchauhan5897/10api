class AddOtpToAuth1 < ActiveRecord::Migration[5.0]
  def change
    add_column :auth1s, :otp, :string
  end
end
