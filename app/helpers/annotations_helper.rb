module AnnotationsHelper
  # def show_context
  #
  # end

  # Displays notes if there are any
  def display_notes(annotation)
    render 'annotations/notes', annotation: annotation if annotation.notes
    # content_tag(:div, annotation.notes, class: 'p-6 shadow-md border')
  end

  # Grep wouldn't find 'cross-boundary' highlights; e.g. anything with newlines (\n) in them.
  #   - Because of this, we split by \n and only search for the first part
  #   - It re-adds the consequential parts to the output after search matched
  def show_paragraph_of(annotation)
    full_text = annotation.book.full_text

    # We split and only search for the first part, before the newline
    hl_split = annotation.highlighted_text.split("\n")
    highlighted_text = hl_split[0]

    regexp = /.*#{Regexp.escape(highlighted_text)}.*/
    full_text =~ /#{regexp}/

    match = Regexp.last_match
    if match
      if hl_split.size > 1
        # Re-add the previously stripped parts to the matched search result
        "#{match}\n#{hl_split[1..].join(' ')}"
      else
        match
      end
    else
      # TODO: If the highlight doesn't match due to other errors, show original for now.
      #   - e.g. nokogiri strips some special chars when converting epub to text,
      #     but the highlights have it still..
      "Showing original: #{annotation.highlighted_text}"
    end
  end

end
