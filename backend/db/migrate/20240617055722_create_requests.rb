class CreateRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :requests do |t|
      t.string :title, null: false
      t.text :description, null: true
      t.text :thumbnail_pic, null: false
      t.string :category, null: false
      t.point :location, null: false
      t.date :date, null: false
      t.integer :number_of_pax, null: false
      t.integer :duration, null: false
      t.string :reward, null: false
      t.string :reward_type, null: false
      t.string :status, null: false

      t.reference :created_by, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
