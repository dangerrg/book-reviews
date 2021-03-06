require "application_system_test_case"

class ReviewCommentsTest < ApplicationSystemTestCase
  test 'adding a Comment to an Review' do
    user = User.new email: 'user_email@epfl.ch'
    user.save!

    review = Review.new book_title: 'Memoirs of a Geisha', author:'', user: user
    review.save

    visit(new_user_path)
    fill_in('Email', with: user.email)
    click_on('Log in')

    visit(review_path(review))
    fill_in('Add a comment', with: "I read this a long time ago ---(a favorite) --- Its amazing a 'male' wrote this book. (sure 'felt' like a female speaking).")
    click_on('Post', match: :first)
    assert_equal review_path(review), page.current_path
    assert page.has_content?("I read this a long time ago ---(a favorite) --- Its amazing a 'male' wrote this book. (sure 'felt' like a female speaking).")
  end

  test 'comments cannot be added when not logged in' do
    review = Review.new book_title: 'Try God Help the Child', author: 'Toni Morrison', user: User.new
    review.save!

    visit(review_path(review))

    refute page.has_content?('Add a Comment')
  end
end
