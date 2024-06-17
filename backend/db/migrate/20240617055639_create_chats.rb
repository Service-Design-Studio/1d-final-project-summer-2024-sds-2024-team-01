class CreateChats < ActiveRecord::Migration[7.1]
  def change
    create_table :chats do |t|

      t.references :applicant_id, null: false, foreign_key: { to_table: :users }
      t.references :requester_id, null: false, foreign_key: { to_table: :users }
      t.references :application_id, null: false, foreign_key: { to_table: :request_applications }

      t.timestamps
    end
  end
end
