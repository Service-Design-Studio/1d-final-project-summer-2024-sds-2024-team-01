class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.string :header, null: false
      t.string :message, null: false
      t.string :url, null: false
      t.boolean :read, default: false
      t.boolean :show, default: true
      t.references :notification_for, null: false, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
