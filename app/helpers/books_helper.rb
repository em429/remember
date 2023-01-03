module BooksHelper
  def book_cover(book)
    if book.cover.attached?
      image_tag(book.cover)
    else
      image_tag('book-cover-placeholder.jpg')
    end
  end
end