class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.references :book, null: false, foreign_key: true
      t.integer :rating
      t.text :content
      t.boolean :banned

      t.timestamps
    end
  end
end
