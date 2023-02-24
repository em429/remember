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

  test "login add a book and import annotations" do
    visit root_url
    # Login
    fill_in 'Email', with: 'default-test@test.com'
    fill_in 'Password', with: 'asdf1234'
    click_button "Log in"
    assert page.has_content? 'Profile' 

    # Add book
    click_link 'Add Book'
    assert page.has_content? 'Title'
    attach_file('book[epub]', "#{Rails.root}/test/fixtures/files/book.epub")
    attach_file('book[cover]', "#{Rails.root}/test/fixtures/files/cover.jpg")
    fill_in 'Title', with: 'Test Book'
    fill_in 'Author', with: 'John Doe'
    click_button 'Add Book'
    assert page.has_content? 'Test Book'
    assert page.has_content? 'by John Doe'
    assert page.has_content? 'Non-Fiction'
    assert page.has_content? 'Extracted plaintext is available in the database for this book.'

    # Import annotations
    attach_file('opf_file', "#{Rails.root}/test/fixtures/files/metadata.opf")
    click_button 'Import'
    assert page.has_content? 'By writing continuously, you force the edit-crazy part of your mind into a subordinate position'
    
    # Visit a single annotation
    first('.simple-card > a').click
    assert page.has_content? 'Test Book by John Doe'
    
  end

  test "editing a book" do
    visit root_url
    # Login
    fill_in 'Email', with: 'default-test@test.com'
    fill_in 'Password', with: 'asdf1234'
    click_button "Log in"
    assert page.has_content? 'Profile'

    click_link 'My Books'
    click_link 'Missing Text Book'
    assert page.has_content? 'No plaintext'
    
    # Add missing cover and epub, change Author
    click_link 'Edit'
    assert page.has_content? 'Editing Missing Text Book'
    attach_file('book[cover]', "#{Rails.root}/test/fixtures/files/cover.jpg")
    attach_file('book[epub]', "#{Rails.root}/test/fixtures/files/book.epub")
    fill_in "Author", with: "Mary Doh"
    click_button 'Add Book'
    assert page.has_content? 'Mary Doh'
    assert page.has_content? 'Extracted plaintext is available'
    
  end

  test "showing book with missing attachments" do
    visit root_url
    # Login
    fill_in 'Email', with: 'default-test@test.com'
    fill_in 'Password', with: 'asdf1234'
    click_button "Log in"
    assert page.has_content? 'Profile'
    
    click_link 'My Books'
    click_link 'How to do everything'
    assert page.has_content? 'How to do everything'
  end

  # test "adding notes to annotation" do
  #   
  # end

  
end
