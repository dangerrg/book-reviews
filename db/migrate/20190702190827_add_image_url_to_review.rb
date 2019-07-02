class AddImageUrlToReview < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :image_url, :string
  end
end
