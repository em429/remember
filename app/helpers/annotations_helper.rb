module AnnotationsHelper
  # def show_context
  #
  # end

  # Displays notes if there are any
  def display_notes(annotation)
    render 'annotations/notes', annotation: annotation if annotation.notes
    # content_tag(:div, annotation.notes, class: 'p-6 shadow-md border')
  end

  def show_paragraph_of(annotation)
    full_text = annotation.book.full_text

    hl_split = annotation.highlighted_text.split("\n")
    highlighted_text = hl_split[0]

    regexp = /.*#{Regexp.escape(highlighted_text)}.*/
    full_text =~ /#{regexp}/

    match = Regexp.last_match
    if match
      if hl_split.size > 1
        "#{match}\n#{hl_split[1..].join(' ')}"
      else
        match
      end
    else
      "Showing original: #{annotation.highlighted_text}"
    end
    
  end
end
