require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]

  def capybara_log_in_as(user, password: 'asdf1234')
    visit root_url
    fill_in 'Email', with: user.email
    fill_in 'Password', with: password
    click_button "Log in"
    assert page.has_content? 'Profile' 
  end
  
end
