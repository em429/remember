require "test_helper"

class BookTest < ActiveSupport::TestCase
  def setup
    @user = FactoryBot.create(:user)
    # I set factorybot to create a book without attachments by default.
    # Use cover_path and epub_path transietn attributes to add attachments
    @book = FactoryBot.create(:book)
  end

  test "should save book without attachments" do
    assert @book.save, "Couldn't save without attachemnts"
  end
  
  test "should not save blank book" do
    blank_book = Book.new
    assert_not blank_book.save, "Saved blank book"
  end
end
