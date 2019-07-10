class CreateJoinTableReviewsUsers < ActiveRecord::Migration[5.2]
  def change
    create_join_table :reviews, :users do |t|
      # t.index [:review_id, :user_id]
      # t.index [:user_id, :review_id]
    end
  end
end
