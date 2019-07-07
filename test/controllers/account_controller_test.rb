require 'test_helper'

class AccountControllerTest < ActionDispatch::IntegrationTest
  test "should get reviews" do
    get account_reviews_url
    assert_response :success
  end

end
