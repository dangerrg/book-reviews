require 'application_system_test_case'

class SimpleNavigationsTest < ApplicationSystemTestCase
  test 'search term is displayed' do
    visit('/')
    assert page.has_content?('Book Reviews')
    fill_in('q', with: 'Aurora').send_keys(:enter)
    assert has_content?('Aurora')
    assert current_url.include?('q=Aurora')
  end
end