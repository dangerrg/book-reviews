require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  test 'One matching result' do
    review = Review.new book_title: 'Fifty Shades of Grey',
                        author: 'E.L. James',
                        user: User.new
    review.save!
    assert_equal Review.search('E.L. James').length, 1
  end

  test 'No matching result' do
    review = Review.new book_title: 'The Hunger Games',
                        author: 'Suzanne Collins',
                        user: User.new
    review.save!
    assert_empty Review.search('snorkelling')
  end

  test 'Two matching result' do
    review_1 = Review.new book_title: 'Catching Fire (The Hunger Games, #2)',
                          author: 'Suzanne Collins',
                          user: User.new
    review_1.save!
    review_2 = Review.new book_title: 'Mockingjay (The Hunger Games, #3)',
                          author: 'Suzanne Collins',
                          user: User.new
    review_2.save!
    assert_equal Review.search('Games').length, 2
  end

  test 'most_recent with no Reviews' do
    assert_empty Review.most_recent
  end

  test 'most_recent with two Reviews' do
    review_1 = Review.new book_title: 'Title review_1',
                          author: 'Author_1', user: User.new
    review_1.save!
    review_2 = Review.new book_title: 'Title review_2',
                          author: 'Author_2', user: User.new
    review_2.save!

    assert_equal Review.most_recent.length, 2
    assert_equal Review.most_recent.first, review_2
  end

  test 'most_recent with six Reviews' do
    6.times do |i|
      review = Review.new book_title: "Fast and Furious #{i + 1}",
                          author: 'Trista Ann Michaels',
                          user: User.new
      review.save!
    end

    assert_equal Review.most_recent.length, 6
    assert_equal Review.most_recent.first.book_title, 'Fast and Furious 6'
  end

  test 'presence of book title' do
    review = Review.new
    refute review.valid?
  end

  test 'maximum length of author' do
    review = Review.new book_title: 'Fast and Furious saga 3',
                        author: 'Trista Ann Michaels, Trista Ann Michaels, Trista Ann Michaels, Trista Ann Michaels, Trista Ann Michaels, Trista Ann Michaels',
                        user: User.new
    refute review.valid?
  end

  test 'presence of author' do
    review = Review.new book_title: 'Fast and Furious saga 3'
    assert review.valid?
  end
end
