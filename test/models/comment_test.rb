require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test 'changing the associated Review for a Comment' do
    review = Review.new book_title: "Learn French! Apprends l'Anglais!", user: User.new
    review.save!

    comment = Comment.new body: "French words. Like cause teaches French words. Its just one of the best books in the world. The coolest ever!!", review: review, user: User.new
    comment.save!

    review_2 = Review.new book_title: "Learn French - Word Power 101", user: User.new
    review_2.save!

    comment.review = review_2
    comment.save!
    assert_equal review_2, Comment.first.review
  end

  test 'cascading save' do
    review = Review.new book_title: 'The First Days', user: User.new
    review.save!

    comment = Comment.new body: "This book reminds me of so many movies. It’s Thelma & Louise meets Mr & Mrs Smith meets Pulp Fiction meets The Killer meets The Day of the Triffids. ", user: User.new
    review.comments << comment
    review.save!

    assert_equal comment, Comment.first
  end

  test 'Comments are ordered correctly' do
    review = Review.new book_title: 'Animals Make Us Human: Creating the Best Life for Animals', user: User.new
    review.save!

    comment = Comment.new body: "Temple Grandin writes about the four emotions of animals - fear, panic, rage, and seeking. It was like she read my diary! (just kidding)", user: User.new
    another_comment = Comment.new body: "In this book, Grandin offers up the latest research into animal behavior, giving advice on home to make pets happier and less troubled.", user: User.new

    review.comments << comment
    review.comments << another_comment
    review.save!

    assert_equal review.comments.first, comment
    assert_equal 2, review.comments.length
  end
end
