class CreateCompanyCode < ActiveRecord::Migration[7.1]
  def change
    create_table :company_codes do |t|
      t.bigint :company_id, null: false
      t.string :status, null: false
      t.timestamps
    end
    add_foreign_key :company_codes, :companies, column: :company_id
  end
end
