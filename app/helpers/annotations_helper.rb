module AnnotationsHelper
  def render_simple_card(annotation)
    render 'annotations/simple_card', annotation: annotation unless annotation.highlighted_text.blank?
  end

  def render_full_card(annotation)
    render 'annotations/full_card', annotation: annotation unless annotation.highlighted_text.blank?
  end

  # Displays notes if there are any
  def display_notes(annotation)
    render 'annotations/notes', annotation: annotation if annotation.notes
  end

  def show_context(annotation, radius)
    return 'No highlights' if annotation.highlighted_text.blank?
    context = highlight(
      excerpt(
        annotation.book.plaintext,
        annotation.highlighted_text,
        radius: radius
      ),
      annotation.highlighted_text
    )
    if context.blank?
      "Couldn't match the highlight in the book. This is a known bug caused by very slight whitespace mismatches, working on a fix."
    else
      context
    end
  end

end
