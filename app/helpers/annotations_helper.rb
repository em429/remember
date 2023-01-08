module AnnotationsHelper
  # def show_context
  #
  # end

  # Displays notes if there are any
  def display_notes(annotation)
    render 'annotations/notes', annotation: annotation if annotation.notes
  end

  def show_neighbors_of(annotation)
    full_text = annotation.book.full_text
    original_hl = annotation.highlighted_text.strip

    # We split and only search for the first part, before the newline
    original_hl_split = original_hl.split("\n")

    first_half = original_hl_split[0]
    second_half = original_hl_split[1..].join(' ')
    original_hl_without_newline = "#{first_half}#{second_half}"

    eol = "\n"
    context_lines = 2
    context = "((?:.*#{eol}){#{context_lines}})"

    regexp = /.*#{Regexp.escape(first_half)}.*#{eol}/
    full_text =~ /^#{context}(#{regexp})#{context}/

    before = Regexp.last_match(1)
    # Here we don't readd the second half, (unlike in show_paragraph_of),
    # as it will be contained in $after regex match, so it would produce
    # a duplicate line.
    matched_paragraph = Regexp.last_match(2).to_s
    after = Regexp.last_match(3)

    # Return match with neighboring lines
    if !matched_paragraph.blank?
      # We split by the original highlight's first half
      split = "#{before}#{matched_paragraph}#{after}".split(first_half)
      raw("#{split[0]}<span class=\"bg-yellow-100\">#{first_half}</span>#{split[1]}")
    else
      "Couldn't load extra context."
    end
  end

  # Grep wouldn't find 'cross-boundary' highlights; e.g. anything with newlines (\n) in them.
  #   - Because of this, we split by \n and only search for the first part
  #   - We re-add the consequential parts to the output after search matched
  def show_paragraph_of(annotation)
    full_text = annotation.book.full_text
    original_hl = annotation.highlighted_text.strip

    # We split and only search for the first part, before the newline
    original_hl_split = original_hl.split("\n")

    first_half = original_hl_split[0].remove("\n")
    second_half = original_hl_split[1..].join(' ').remove("\n")
    original_hl_without_newline = "#{first_half}#{second_half}"

    regexp = /.*#{Regexp.escape(first_half)}.*/
    full_text =~ /#{regexp}/

    # FIXME: -- very buggy, repeats itself.. etc
    # One of the bugs are caused by newlines, (\n) in text
    # i was using 726 as one of the examples

    # Here we re-add the second half
    matched_paragraph = "#{Regexp.last_match}#{second_half}"
    if !matched_paragraph.blank?
      split = matched_paragraph.to_s.split(original_hl_without_newline)
      # Add yellow color to the original highlighted text (without newlines now :) )
      raw("#{split[0]}<span class=\"bg-yellow-100\">#{original_hl_without_newline}</span>#{split[1]}")

    else
      # FIXME: If the highlight doesn't match due to other errors, show original for now.
      #   - e.g. nokogiri strips some special chars when converting epub to text,
      #     but the highlights have it still..
      "Couldn't load containing paragraph, likely due to HTML entity character mismatch."
    end
  end
end
