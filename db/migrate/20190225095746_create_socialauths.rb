class CreateSocialauths < ActiveRecord::Migration[5.0]
  def change
    create_table :socialauths do |t|
      t.string :device_type
      t.string :device_id
      t.references :user1, foreign_key: true

      t.timestamps
    end
  end
end
