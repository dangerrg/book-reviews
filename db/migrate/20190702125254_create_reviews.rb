class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :book_title
      t.string :body
      t.string :author

      t.timestamps
    end
  end
end
