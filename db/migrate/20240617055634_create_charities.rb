class CreateCharities < ActiveRecord::Migration[7.1]
  def change
    create_table :charities do |t|
      t.string :charity_name, null: false
      t.string :status, null: false
      t.timestamps
    end
  end
end
