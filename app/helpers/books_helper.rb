module BooksHelper
  def fiction_or_not_tag(book)
    if book.fiction
      "Fiction"
    else
      "Non-Fiction"
    end
  end
  def book_cover(book)
    if book.cover.attached?
      image_tag(book.cover)
    else
      image_tag('book-cover-placeholder.jpg')
    end
  end
end
