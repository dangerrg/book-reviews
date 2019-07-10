class BooksController < ApplicationController
  def create
    user = User.find(params[:user_id])
    review = Review.find(params[:review_id])

    user.books << review

    redirect_to review_path(review)
  end
end
