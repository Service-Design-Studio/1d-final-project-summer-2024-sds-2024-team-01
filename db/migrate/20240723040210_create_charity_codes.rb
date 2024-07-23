class CreateCharityCodes < ActiveRecord::Migration[7.1]
  def change
    create_table :charity_codes do |t|
      t.bigint :charity_id, null: false
      t.string :status, null: false
      t.string :code, null: false
      t.timestamps
    end
    add_foreign_key :charity_codes, :charities, column: :charity_id
  end
end
