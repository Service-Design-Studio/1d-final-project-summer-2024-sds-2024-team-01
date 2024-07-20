class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|

      t.string :header
      t.string :message
      t.string :url
      t.boolean :read, default: false
      t.references :notification_for, null: false, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
