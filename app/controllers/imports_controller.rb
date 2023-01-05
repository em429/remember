require 'extract_highlights'

class ImportsController < ApplicationController
  def index; end

  def create
    extracted = extract_highlights(params[:opf_file])
    extracted.each do |e|
      # Rails.logger.debug "Creating #{e['annotation']['highlighted_text']}"
      Annotation.create!(
        highlighted_text: e['annotation']['highlighted_text'],
        notes: e['annotation']['notes'],
        start_cfi: e['annotation']['start_cfi'],
        end_cfi: e['annotation']['end_cfi'],
        book_id: params[:book_id]
      )
    end
    redirect_to book_path(params[:book_id])
  end
end
