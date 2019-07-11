require "application_system_test_case"

class ShowReviewsTest < ApplicationSystemTestCase
  test 'create new review' do
    my_review = Review.new book_title: 'Fifty Shades of Grey',
                        author: 'E.L. James',
                        user: User.new
    my_review.save!

    visit(review_path(my_review))
    assert page.has_content?('Fifty Shades of Grey')
    assert page.has_content?('E.L. James')
    assert page.has_content?(my_review.created_at.strftime("%d %b '%y"))

    click_on('Edit')

    assert_equal current_path, edit_review_path(my_review)
  end
end
