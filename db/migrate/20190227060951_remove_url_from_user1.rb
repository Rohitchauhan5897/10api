class RemoveUrlFromUser1 < ActiveRecord::Migration[5.0]
  def change
    remove_column :user1s, :url, :string
  end
end
