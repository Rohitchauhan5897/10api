class AddImageToUser1 < ActiveRecord::Migration[5.0]
  def change
    add_column :user1s, :image, :string
  end
end
