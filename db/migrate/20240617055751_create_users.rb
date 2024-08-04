class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :number, default: ""
      t.string :description, default: ""
      t.string :status, null: false, default: "active"
      t.integer :total_hours, default: 0
      t.integer :weekly_hours, default: 0
      t.references :role, foreign_key: true, default: "1"
      t.references :company, foreign_key: true, null: true
      t.references :charity, foreign_key: true, null: true
      t.string :encrypted_password, null: false, default: ""
      t.timestamps

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_number
      
    end

    add_index :users, :number,               unique: true
    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    end
end
