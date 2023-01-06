module BooksHelper
  def random_highlight(book)
    book.annotations.all.order('RANDOM()').first.highlighted_text
  end

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

  def full_text_extract_form(book)
    if !book.full_text.blank?
      link_to 'Extracted full text is available in the database for this book.', book_full_text_path(book)
    else
      button_to 'Extract Text', book_start_text_extraction_path(book), method: :post, class: 'btn'
    end
  end
end
