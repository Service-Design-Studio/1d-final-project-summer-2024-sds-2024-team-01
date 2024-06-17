class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.integer :rating, null: false
      t.text :review_content, null: true

      t.references :review_for, null: false, foreign_key: { to_table: :users }
      t.references :review_by, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
