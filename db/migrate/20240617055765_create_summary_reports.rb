class CreateSummaryReports < ActiveRecord::Migration[7.1]
  def change
    create_table :summary_reports do |t|
      t.bigint :requested_by, null: false

      t.timestamps
    end
    add_foreign_key :summary_reports, :users, column: :requested_by
  end
end
