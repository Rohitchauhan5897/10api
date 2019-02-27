class AddUrlToUser1 < ActiveRecord::Migration[5.0]
  def change
    add_column :user1s, :url, :string
  end
end
