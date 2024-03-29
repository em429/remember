module AnnotationsHelper
  def render_annotation(a)
    return if a.highlighted_text.blank?

    render 'annotations/card',
           flashcard: a.flashcard, annotation: a
  end

  def button_to_star(annotation)
    if annotation.starred
      button_to annotation_star_path(id: annotation.id), method: :patch do
        render 'svgs/star', fill: 'fill-gray-300', stroke: 'stroke-gray-300'
      end
    else
      button_to annotation_star_path(id: annotation.id), method: :patch do
        render 'svgs/star', stroke: 'stroke-gray-400'
      end
    end
  end

  # Displays notes if there are any
  def display_notes(annotation)
    render 'annotations/notes', annotation: annotation if annotation.notes
  end

  # This must be like this: full class names, otherwise the tailwind JIT wont compile them.
  def color_to_tailwind_bg(color)
    case color
    when 'yellow'
      'bg-yellow-100'
    when 'red'
      'bg-red-100'
    when 'green'
      'bg-green-100'
    when 'purple'
      'bg-purple-100'
    when 'blue'
      'bg-blue-100'
    else
      'bg-gray-200'
    end
  end

  def color_to_tailwind_border(color)
    case color
    when 'yellow'
      'border-yellow-300'
    when 'red'
      'border-red-300'
    when 'green'
      'border-green-300'
    when 'purple'
      'border-purple-300'
    when 'blue'
      'border-blue-300'
    else
      'border-gray-500'
    end
  end

  def show_context(annotation, radius)
    return 'No highlights' if annotation.highlighted_text.blank?

    color_class = color_to_tailwind_bg(annotation.color)

    context = highlight(
      excerpt(
        annotation.book.plaintext,
        annotation.highlighted_text,
        radius:
      ),
      annotation.highlighted_text,
      highlighter: '<mark class="' + color_class + '">\1</mark>'
    )
    if context.blank?
      "Couldn't match the highlight in the book. This is a known bug caused by very slight whitespace mismatches, working on a fix."
    else
      context
    end
  end
end
