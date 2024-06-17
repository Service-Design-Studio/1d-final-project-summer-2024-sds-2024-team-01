class CreateSummaryReports < ActiveRecord::Migration[7.1]
  def change
    create_table :summary_reports do |t|
      t.references :requested_by, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
