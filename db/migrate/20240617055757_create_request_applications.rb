class CreateRequestApplications < ActiveRecord::Migration[7.1]
  def change
    create_table :request_applications do |t|
      # Statuses available:
      # Pending
      # Accepted
      # Rejected
      # Withdrawn
      t.string :status, null: false, default: 'Pending'

      t.references :applicant, null: false, foreign_key: { to_table: :users }
      t.references :request, null: false, foreign_key: { to_table: :requests }

      t.timestamps
    end
  end
end
