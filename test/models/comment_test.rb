require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test 'changing the associated Review for a Comment' do
    review = Review.new book_title: 'Learn digicupunture'
    review.save!

    comment = Comment.new body: "I'd like to do this!", review: review, user: User.new
    comment.save!

    review_2 = Review.new book_title: 'Learn advance math'
    review_2.save!

    comment.review = review_2
    comment.save!
    assert_equal review_2, Comment.first.review
  end

  test 'cascading save' do
    review = Review.new book_title: 'Exiciting review'
    review.save!

    comment = Comment.new body: 'Great review!', user: User.new
    review.comments << comment
    review.save!

    assert_equal comment, Comment.first
  end

  test 'Comments are ordered correctly' do
    review = Review.new book_title: 'Awesome review'
    review.save!

    comment = Comment.new body: "I'd like to do this!", user: User.new
    another_comment = Comment.new body: "I agree! I'd like to do this as well", user: User.new

    review.comments << comment
    review.comments << another_comment
    review.save!

    assert_equal review.comments.first, comment
    assert_equal 2, review.comments.length
  end
end
