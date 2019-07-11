require "application_system_test_case"

class LogInsTest < ApplicationSystemTestCase
  test 'sign up creates a User' do
    visit(new_user_path)
    fill_in('Email', with: 'new@epfl.ch')
    click_on('Log in')

    assert_equal 1, User.all.length
    assert_equal 'new@epfl.ch', User.first.email
  end

  test 'log in does not create a User' do
    user = User.new email: 'martha@epfl.ch'
    user.save!
    visit(new_user_path)
    fill_in('Email', with: user.email)
    click_on('Log in')
    assert_equal 1, User.all.length
  end
end
