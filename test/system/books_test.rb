require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = books(:one)
    @missing_attachments_book = Book.find_by(title: "Missing Attachments Book")
    @user = User.find_by(email: "default-test@test.com")

    # Login
    visit root_url
    fill_in 'Email', with: 'default-test@test.com'
    fill_in 'Password', with: 'asdf1234'
    click_button "Log in"
    assert page.has_content? 'Profile' 
  end

  test "visiting the index" do
    visit books_url
    assert_selector "h1", text: "Books"
  end

  test "should create book" do
    visit books_url
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
    
  end

  test "should update Book" do
    visit book_url(@book)

    click_link 'My Books'
    click_link 'Missing Attachments Book'
    assert page.has_content? 'No plaintext'
    
    # Add missing cover and epub, change Author
    click_link 'Edit'
    assert page.has_content? 'Editing Missing Attachments Book'
    attach_file('book[cover]', "#{Rails.root}/test/fixtures/files/cover.jpg")
    attach_file('book[epub]', "#{Rails.root}/test/fixtures/files/book.epub")
    fill_in "Author", with: "Mary Doh"
    click_button 'Add Book'
    assert page.has_content? 'Mary Doh'
    assert page.has_content? 'Extracted plaintext is available'
  end

  test "should destroy Book" do
    visit book_url(@book)
    click_button "Delete", match: :first

    assert_text "Book was successfully destroyed"
  end

  test "should show index with missing attachments" do
    visit books_url
    assert page.has_content? "Missing Attachments Book"
  end

  test "should show book with missing attachments" do
    visit book_url(@missing_attachments_book)
    assert page.has_content? 'No plaintext'
  end

   
end
