class CreateAuth1s < ActiveRecord::Migration[5.0]
  def change
    create_table :auth1s do |t|
      t.string :password_digest
      t.references :user1, foreign_key: true

      t.timestamps
    end
  end
end
