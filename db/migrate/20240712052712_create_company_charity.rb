class CreateCompanyCharity < ActiveRecord::Migration[7.1]
  def change
    create_table :company_charities do |t|
      t.bigint :company_id, null: false
      t.bigint :charity_id, null: false
      t.timestamps
    end

    add_foreign_key :company_charities, :companies, column: :company_id
    add_foreign_key :company_charities, :charities, column: :charity_id
  end
end
