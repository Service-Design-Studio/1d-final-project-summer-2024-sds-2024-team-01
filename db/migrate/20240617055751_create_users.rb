class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.text :profile_picture, null: true
      t.string :name, null: false
      t.string :nric, limit: 9, null: false
      t.string :number, null: false
      t.string :email, null: false
      t.string :status, null: false
      t.references :role, foreign_key: true
      t.references :company, foreign_key: true, null: true
      t.references :charity, foreign_key: true, null: true

      t.timestamps
    end
  end
end
