class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|

      t.integer :rating, null: false
      t.text :review_content, null: true

      t.bigint :review_for, null: false
      t.bigint :review_by, null: false

      t.timestamps
    end
    add_foreign_key :reviews, :users, column: :review_for
    add_foreign_key :reviews, :users, column: :review_by
  end
end
