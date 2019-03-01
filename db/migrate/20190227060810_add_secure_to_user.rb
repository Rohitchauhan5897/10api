class AddSecureToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :secure_url, :string
  end
end
