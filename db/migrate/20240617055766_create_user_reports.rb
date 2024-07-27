class CreateUserReports < ActiveRecord::Migration[7.1]
  def change
    create_table :user_reports do |t|
      t.text :report_reason, null: false
      t.string :status, null: false, default: 'under_review'
      
      t.references :reported_by, null: false, foreign_key: { to_table: :users }
      t.references :reported_user, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
