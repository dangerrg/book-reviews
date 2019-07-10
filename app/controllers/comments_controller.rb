class CommentsController < ApplicationController
  def create
    user = User.find(session[:user_id])
    comment = Comment.new comment_params
    review = Review.find(params[:review_id])
    comment.review = review
    comment.user = user
    comment.save

    redirect_to review_path(review)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
