class CreateUserReports < ActiveRecord::Migration[7.1]
  def change
    create_table :user_reports do |t|
      t.text :report_reason, null: false
      t.string :status, null: false, default: 'under_review'
      t.bigint :reported_by, null: false
      t.bigint :reported_user, null: false
      t.timestamps
    end

    add_foreign_key :user_reports, :users, column: :reported_by
    add_foreign_key :user_reports, :users, column: :reported_user
  end
end
