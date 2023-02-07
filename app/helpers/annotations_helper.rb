module AnnotationsHelper
  def render_paragraph_card(annotation)
    render 'annotations/paragraph_card', annotation: annotation unless annotation.highlighted_text.blank?
  end

  def render_annotation_card(annotation)
    render 'annotations/card', annotation: annotation unless annotation.highlighted_text.blank?
  end

  # Displays notes if there are any
  def display_notes(annotation)
    render 'annotations/notes', annotation: annotation if annotation.notes
  end

  def show_context(annotation, radius)
    return 'No highlights' if annotation.highlighted_text.blank?
    context = highlight(
      excerpt(annotation.book.plaintext, annotation.highlighted_text, radius: radius),
      annotation.highlighted_text
    )
    if context.blank?
      "Couldn't find a match for this annotation in the book."
    else
      context
    end
  end

end
