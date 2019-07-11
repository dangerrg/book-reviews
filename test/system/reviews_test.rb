require "application_system_test_case"

class ReviewsTest < ApplicationSystemTestCase
  test 'create new review' do
    user = User.new email: 'test@epfl.ch'
    user.save!

    visit(new_user_path)
    fill_in('Email', with: user.email)
    click_on('Log in')

    visit(new_review_path)
    fill_in('Book title', with: 'Skydiving in Interlaken')
    fill_in('Author', with: 'author65')
    fill_in('Image url', with: 'http://monkeychute.co/wp-content/uploads/2018/01/skydive-interlaken.jpg')
    click_on('Create Review')
    assert page.has_content?('Skydiving in Interlaken')
  end

  test 'that Reviews are loaded in the index' do
    first_review = Review.new book_title: 'Cycle across Australia',
                          user: User.new
    first_review.save!

    second_review = Review.new book_title: 'See a giraffe in the wild',
                           user: User.new
    second_review.save!

    visit(reviews_path)
    assert page.has_content?('Cycle across Australia')
    assert page.has_content?('See a giraffe in the wild')
  end

  test 'Test for editing reviews' do
    new_review = Review.new book_title: 'Unedited new review', user: User.new
    new_review.save!
    visit(edit_review_path(new_review))
    fill_in('Author', with: 'author10')
    fill_in('Book title', with: 'Build an amazing web app')
    click_on('Update Review')
    click_on('Build an amazing web app')

    assert page.has_content?('Build an amazing web app')
    assert page.has_content?('author10')
  end

  test 'search' do
    review_1 = Review.new book_title: 'Climb Mont Blanc', user: User.new
    review_1.save!

    review_1 = Review.new book_title: 'Visit Niagara Falls', user: User.new
    review_1.save!

    visit(root_path)
    fill_in('q',	with: 'Mont')
    click_on('Search', match: :first)

    assert current_path.include?(reviews_path)
    assert page.has_content?('Climb Mont Blanc')
    refute page.has_content?('Visit Niagara Falls')
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
    review_1 = Review.new book_title: 'Go cycling across Europe',
                      author: 'An amazing way to see lots of Europe',
                      user: User.new
    review_1.save!
    review_2 = Review.new book_title: 'Visit Provence',
                      author: 'Go to vineyards, go cycling up Mont Ventoux, see the fields of lavender',
                      user: User.new
    review_2.save!
    review_3 = Review.new book_title: 'Overnight hike in Switzerland',
                      author: 'Stay in a Swiss refuge in the mountains',
                      user: User.new
    review_3.save!

    visit(root_path)

    fill_in('q', with: 'cycling')
    click_on('Search', match: :first)

    assert page.has_content?('Go cycling across Europe')
    assert page.has_content?('Visit Provence')
    refute page.has_content?('Overnight hike in Switzerland')
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

  test 'exciting review update with no title' do
    review = Review.new book_title: 'Exciting review!', user: User.new
    review.save!
    visit(edit_review_path(review))
    fill_in('Book title', with: '')
    click_on('Update Review')
    assert page.has_content?("Book title can't be blank")
  end
end
