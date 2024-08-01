class CreateRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :requests do |t|
      t.string :title, null: false
      t.text :description, null: true
      t.string :category, null: false
      t.st_point :location, null: false, geographic: true
      t.date :date, null: false
      t.time :start_time, null: false
      t.integer :number_of_pax, null: false
      t.integer :duration, null: false
      t.string :reward_type, null: false
      t.string :reward, null: true
      t.string :status, null: false

      t.bigint :created_by, null: false

      t.timestamps
    end
    add_foreign_key :requests, :users, column: :created_by
  end
end
