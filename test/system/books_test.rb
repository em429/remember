require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = books(:one)
    @missing_attachments_book = books(:missing_attachments)
    @user = users(:mary)

    # Login
    visit root_url
    fill_in 'Email', with: 'mary@test.com'
    fill_in 'Password', with: 'asdf1234'
    click_button "Log in"
    assert page.has_content? 'Profile' 
  end

  test "visiting the index" do
    visit books_url
    assert_selector "h1", text: "Books"
  end

  test "should create Book" do
    visit books_url
    click_link 'Add Book'
    assert page.has_content? 'Title'
    attach_file('book[epub]', "#{Rails.root}/test/fixtures/files/genius.epub")
    attach_file('book[cover]', "#{Rails.root}/test/fixtures/files/cover.jpg")
    fill_in 'Title', with: 'Test Uploaded Book'
    fill_in 'Author', with: 'John Doe'
    click_button 'Add Book'
    assert page.has_content? 'Test Uploaded Book'
    assert page.has_content? 'by John Doe'
    assert page.has_content? 'Non-Fiction'
    assert page.has_content? 'Extracted plaintext is available in the database for this book.'
    
  end

  test "should update Book" do
    visit book_url(@missing_attachments_book)
    assert page.has_content? 'No plaintext'
    
    # Add missing cover and epub, change Author
    click_link 'Edit'
    assert page.has_content? 'Editing Missing Attachments Book'
    attach_file('book[cover]', "#{Rails.root}/test/fixtures/files/cover.jpg")
    attach_file('book[epub]', "#{Rails.root}/test/fixtures/files/genius.epub")
    fill_in "Author", with: "Mary Doh"
    click_button 'Add Book'
    assert page.has_content? 'Mary Doh'
    assert page.has_content? 'Extracted plaintext is available'
  end

  test "should destroy Book" do
    visit book_url(@book)
    accept_alert do
      click_button "Delete", match: :first
    end
    assert_text "Book successfully deleted"
  end

  test "should show index with missing attachments" do
    visit books_url
    assert page.has_content? "Test Book 1"
    assert page.has_content? "Missing Attachments Book"
    assert page.has_content? "Book With Attachments"
  end

  test "should show Book with missing attachments" do
    visit book_url(@missing_attachments_book)
    assert page.has_content? 'No plaintext'
  end

   
end
