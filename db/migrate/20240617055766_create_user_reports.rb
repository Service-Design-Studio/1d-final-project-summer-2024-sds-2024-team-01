class CreateUserReports < ActiveRecord::Migration[7.1]
  def change
    create_table :user_reports do |t|
      t.text :report_reason, null: false
      t.string :status, null: false

      t.bigint :requested_by, null: false

      t.timestamps
    end
    add_foreign_key :user_reports, :users, column: :requested_by
  end
end
