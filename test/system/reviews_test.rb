require "application_system_test_case"

class ReviewsTest < ApplicationSystemTestCase
  test 'create new review' do
    user = User.new email: 'test@epfl.ch'
    user.save!

    visit(new_user_path)
    fill_in('Email', with: user.email)
    click_on('Log in')

    visit(new_review_path)
    fill_in('Book title', with: 'Skydiving')
    fill_in('Author', with: 'Christopher Meeks')
    fill_in('Image url', with: 'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1266815219l/4576076.jpg')
    click_on('Create Review')
    assert page.has_content?('Skydiving')
  end

  test 'that Reviews are loaded in the index' do
    first_review = Review.new book_title: 'The Skydiving Beavers: A True Tale',
                          author: 'author32',
                          user: User.new
    first_review.save!

    second_review = Review.new book_title: 'Mental Training For Skydiving And Life',
                          author: 'author32',
                           user: User.new
    second_review.save!

    visit(reviews_path)
    assert page.has_content?('The Skydiving Beavers: A True Tale')
    assert page.has_content?('Mental Training For Skydiving And Life')
  end

  test 'Test for editing reviews' do
    new_review = Review.new book_title: 'Help me!', user: User.new
    new_review.save!
    visit(edit_review_path(new_review))
    fill_in('Author', with: 'Kathryn Stockett')
    fill_in('Book title', with: 'The Help')
    click_on('Update Review')
    click_on('The Help')

    assert page.has_content?('The Help')
    assert page.has_content?('Kathryn Stockett')
  end

  test 'search' do
    review_1 = Review.new book_title: 'The Help', author: 'Kathryn Stockett', user: User.new
    review_1.save!

    review_1 = Review.new book_title: 'Mental Training For Skydiving And Life', author: 'John Derosalia', user: User.new
    review_1.save!

    visit(root_path)
    fill_in('q',	with: 'The')
    click_on('Search', match: :first)

    assert current_path.include?(reviews_path)
    assert page.has_content?('The Help')
    refute page.has_content?('The Skydiving Beavers: A True Tale')
  end

  test 'No search results' do
    visit(reviews_path)
    assert page.has_content?('No reviews found')
  end

  test 'homepage highlights' do
    7.times do |i|
      review = Review.new book_title: "Book title Review #{i + 1}", user: User.new
      review.save!
    end
    visit(root_path)

    assert page.has_content?('Book title Review 4')
    assert page.has_content?('Book title Review 3')
    assert page.has_content?('Book title Review 2')
    refute page.has_content?('Book title Review 1')
  end

  test 'when searching by title and description' do
    review_1 = Review.new book_title: 'The Raw Shark Texts',
                      author: 'Steven Hall',
                      user: User.new
    review_1.save!

    review_2 = Review.new book_title: 'Silver Shark',
                      author: 'Ilona Andrews',
                      user: User.new
    review_2.save!

    review_3 = Review.new book_title: 'Tintin and the Lake of Sharks',
                      author: 'Stay in a Swiss refuge in the mountains',
                      user: User.new
    review_3.save!

    visit(root_path)

    fill_in('q', with: 'Shark')
    click_on('Search', match: :first)

    assert page.has_content?('The Raw Shark Texts')
    assert page.has_content?('Silver Shark')
    refute page.has_content?('Tintin and the Lake of Sharks ')
  end

  test 'new review with no title' do
    user = User.new email: 'test@epfl.ch'
    user.save!

    visit(new_user_path)
    fill_in('Email', with: user.email)
    click_on('Log in')

    visit(new_review_path)
    fill_in('Author', with: 'author32')
    click_on('Create Review')
    assert page.has_content?("Book title can't be blank")
  end

  test 'A review update with no title' do
    review = Review.new book_title: 'Help me!!', user: User.new
    review.save!
    visit(edit_review_path(review))
    fill_in('Book title', with: '')
    click_on('Update Review')
    assert page.has_content?("Book title can't be blank")
  end
end
