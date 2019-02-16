class CreateSession1s < ActiveRecord::Migration[5.0]
  def change
    create_table :session1s do |t|
      t.string :token
      t.references :auth1, foreign_key: true

      t.timestamps
    end
  end
end
