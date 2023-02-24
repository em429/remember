require "application_system_test_case"
# Make sure to also set WD_CHROME_PATH chrome / chromium the same version as chromedriver
Selenium::WebDriver::Chrome::Service.driver_path = ENV['WD_CHROMEDRIVER_PATH']


class BasicsTest < ApplicationSystemTestCase
  test "invalid login, successful signup then login" do
    visit root_url
  
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: 'asdf'
    click_on 'Log in'
    assert page.has_content? 'Invalid' 
    click_on 'Sign up now!'
    fill_in 'Username', with: 'test'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: 'asdf1234'
    fill_in 'Confirm password', with: 'asdf1234'
    click_on 'Create User'
    assert page.has_content? 'Profile'
  end

  test "empty signup is invalid" do
    visit root_url
    
    click_on 'Sign up now!'
    click_on 'Create User'
    assert page.has_content? '5 errors prohibited this user from being saved:' 
    fill_in 'Username', with: 'asd'
    click_on 'Create User'
    assert page.has_content? '4 errors prohibited this user from being saved:' 
  end

  test "empty password signup is invalid" do
    visit root_url
    
    click_on 'Sign up now!'
    fill_in 'Username', with: 'asd'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: '        '
    fill_in 'Confirm password', with: '        '
    click_on 'Create User'
    assert page.has_content? "Password must be 8+ characters and must include a number" 
  end

  test "adding a book" do
    visit root_url
    click_on 'Sign up now!'
    fill_in 'Username', with: 'test'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: 'asdf1234'
    fill_in 'Confirm password', with: 'asdf1234'
    click_on 'Create User'
    assert page.has_content? 'Profile' 
    click_on 'Add Book'
    assert page.has_content? 'Title'

    # TODO: upload epub and cover
    
    
    fill_in 'Title', with: 'Test Book'
    fill_in 'Author', with: 'John Doe'
    click_on 'Add Book'
    magic_test
  end

  # test "importing annotations" do
  #   
  # end

  # test "editing book" do
  #   
  # end

  # test "adding notes to annotation" do
  #   
  # end

  
end
