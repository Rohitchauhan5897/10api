class CreateUser1s < ActiveRecord::Migration[5.0]
  def change
    create_table :user1s do |t|
      t.string :firstname
      t.string :lastname
      t.string :username
      t.string :email
      t.string :contact_no
      t.string :gender
      t.date :dob

      t.timestamps
    end
  end
end
