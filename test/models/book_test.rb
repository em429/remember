require "test_helper"

class BookTest < ActiveSupport::TestCase
  test "should save book without attachments" do
    book = Book.new(title: "Model Test", author: "John Doe", user_id: users(:mary).id)
    assert book.save, "Couldn't save without attachemnts"
  end
  
  test "should not save blank book" do
    book = Book.new
    assert_not book.save, "Saved blank book"
  end
end
