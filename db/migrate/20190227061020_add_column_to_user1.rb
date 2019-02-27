class AddColumnToUser1 < ActiveRecord::Migration[5.0]
  def change
    add_column :user1s, :secure_url, :string
  end
end
