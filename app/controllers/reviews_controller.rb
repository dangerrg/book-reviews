class ReviewsController < ApplicationController
  def new
  end
  
  def create
    review = Review.new
    review.book_title = params[:book_title]
    review.body = params[:body]
    review.image_url = params[:image_url]
    review.author = params[:author]
    review.save!
  end
end
