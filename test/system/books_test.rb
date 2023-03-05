require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  setup do
    @user = FactoryBot.create(:user)
    @missing_attachments_book = FactoryBot.create(:book, :without_plaintext, user: @user)
    @book = FactoryBot.create(:book, user: @user,
      epub_path: "#{Rails.root}/test/factories/files/genius/book.epub",
      cover_path: "#{Rails.root}/test/factories/files/genius/cover.jpg" 
    )

    capybara_log_in_as(@user)
  end

  test "visiting the index" do
    visit books_url
    assert_selector "h1", text: "Books"
  end

  test "should create Book" do
    visit books_url
    click_link 'Add Book'
    assert page.has_content? 'Title'

    title = Faker::Book.title
    author = Faker::Book.author
    
    fill_in 'Title', with: title
    fill_in 'Author', with: author
    attach_file('book[epub]', "#{Rails.root}/test/factories/files/segitseg/book.epub")
    attach_file('book[cover]', "#{Rails.root}/test/factories/files/segitseg/cover.jpg")

    click_button 'Add Book'

    assert page.has_content? title
    assert page.has_content? "by #{author}"
    assert page.has_content? 'Non-Fiction'
    assert page.has_content? 'Extracted plaintext is available in the database for this book.'
  end

  test "should add attachments to existing book" do
    visit book_url(@missing_attachments_book)
    assert page.has_content? 'No plaintext'

    click_link 'Edit'
    assert page.has_content? "Editing #{@missing_attachments_book.title}"
    attach_file('book[epub]', "#{Rails.root}/test/factories/files/segitseg/book.epub")
    attach_file('book[cover]', "#{Rails.root}/test/factories/files/segitseg/cover.jpg")
    click_button 'Add Book'
    assert page.has_content? 'Extracted plaintext is available'
    # TODO: assert both cover2.jpg and book2.epub is attached
  end

  test "should update Book" do
    visit book_url(@book)
    assert page.has_content? @book.author

    new_author = Faker::Book.author
    
    # Add missing cover and epub, change Author
    click_link 'Edit'
    assert page.has_content? "Editing #{@book.title}"
    fill_in "Author", with: new_author
    click_button 'Add Book'
    assert page.has_content? new_author
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
    assert page.has_content? @book.title
    assert page.has_content? @missing_attachments_book.title
  end

  test "should show Book with missing attachments" do
    visit book_url(@missing_attachments_book)
    assert page.has_content? 'No plaintext'
  end

   
end
