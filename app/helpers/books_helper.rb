module BooksHelper

  def book_titles_for_select
    [[ "Any", "" ]] + Book.all.pluck(:title)
  end

  # TODO: implement as enum (fiction, non, paper, article..etc)
  def fiction_or_not_tag(book)
    if book.fiction
      'Fiction'
    else
      'Non-Fiction'
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
