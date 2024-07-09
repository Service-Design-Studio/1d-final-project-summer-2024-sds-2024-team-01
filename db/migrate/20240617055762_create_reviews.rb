class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|

      t.integer :rating, null: false
      t.text :review_content, null: true

      t.bigint :request_id, null: false

      t.bigint :review_for, null: false
      t.bigint :created_by, null: false

      t.timestamps
    end
    add_foreign_key :reviews, :users, column: :review_for
    add_foreign_key :reviews, :users, column: :created_by
    add_foreign_key :reviews, :requests, column: :request_id
  end
end
