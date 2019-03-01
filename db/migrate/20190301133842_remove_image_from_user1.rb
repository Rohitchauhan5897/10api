class RemoveImageFromUser1 < ActiveRecord::Migration[5.0]
  def change
    remove_column :user1s, :image, :string
  end
end
