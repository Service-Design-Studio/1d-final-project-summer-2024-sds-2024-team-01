class CreateChats < ActiveRecord::Migration[7.1]
  def change
    create_table :chats do |t|

      t.references :applicant, null: false, foreign_key: { to_table: :users }
      t.references :requester, null: false, foreign_key: { to_table: :users }
      t.references :application, null: false, foreign_key: { to_table: :request_applications }

      t.timestamps
    end
  end
end
