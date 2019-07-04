class ReviewsController < ApplicationController
  def index
    @search_term = params[:q]
    logger.info("Search completed using #{@search_term}.")
    @reviews = Review.search(@search_term)
  end

  def new
    @review = Review.new
  end

  def create
    review = Review.new
    review.book_title = params[:book_title]
    review.body = params[:body]
    review.image_url = params[:image_url]
    review.author = params[:author]
    review.save!

    redirect_to reviews_index_path
  end
end
