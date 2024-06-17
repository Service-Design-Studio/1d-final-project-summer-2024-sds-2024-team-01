class CreateCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :companies do |t|
      t.string :company_name, null: false
      t.string :company_code, limit:20, null: false
      t.string :status, null: false
      t.timestamps
    end
  end
end
