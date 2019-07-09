class ReviewsController < ApplicationController
  def index
    @search_term = params[:q]
    logger.info("Search completed using #{@search_term}.")
    @reviews = Review.search(@search_term)
  end

  def show
    @review = Review.find(params[:id])
    @comment = Comment.new
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_resource_params)
    if @review.save
      redirect_to reviews_path
    else
      render 'new'
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_resource_params)
      redirect_to account_reviews_path
    else
      render 'edit'
    end
  end

  private

  def review_resource_params
    params.require(:review).permit(:book_title, :body, :image_url, :author)
  end
end
