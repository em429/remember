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
    original_hl = annotation.highlighted_text

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
    matched_paragraph = "#{Regexp.last_match(2)}#{second_half}"
    after = Regexp.last_match(3)
    if matched_paragraph
      # Return match with neighboring lines
      # Re-add the previously stripped parts to the matched search result
      split = "#{before}#{matched_paragraph}#{after}".split(first_half)
      # Now we split the full context string by the original highlighted text, to get the
      # start and end points for our span tag.
      raw("#{split[0]}<span class=\"bg-yellow-100\">#{original_hl_without_newline}</span>#{split[1]}")
    else
      "Couldn't load extra context."
    end
  end

  # Grep wouldn't find 'cross-boundary' highlights; e.g. anything with newlines (\n) in them.
  #   - Because of this, we split by \n and only search for the first part
  #   - We re-add the consequential parts to the output after search matched
  def show_paragraph_of(annotation)
    full_text = annotation.book.full_text
    original_hl = annotation.highlighted_text

    # We split and only search for the first part, before the newline
    original_hl_split = original_hl.split("\n")

    first_half = original_hl_split[0]
    second_half = original_hl_split[1..].join(' ')
    original_hl_without_newline = "#{first_half}#{second_half}"

    regexp = /.*#{Regexp.escape(first_half)}.*/
    full_text =~ /#{regexp}/

    # FIXME: i was using 726 as one of the examples
    matched_paragraph = "#{Regexp.last_match}#{second_half}"
    if matched_paragraph
      split = matched_paragraph.to_s.split(first_half)
      # Add yellow color to the original highlighted text (without newlines now :) )
      raw("#{split[0]}<span class=\"bg-yellow-100\">#{original_hl_without_newline}</span>#{split[1]}")
    else
      # TODO: If the highlight doesn't match due to other errors, show original for now.
      #   - e.g. nokogiri strips some special chars when converting epub to text,
      #     but the highlights have it still..
      "Showing original: #{original_hl}"
    end
  end
end
