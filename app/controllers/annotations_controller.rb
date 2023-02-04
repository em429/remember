require 'extract_highlights'

class AnnotationsController < ApplicationController
  def index
    case params[:filter]
    when "random"
      @annotations = Annotation.random_single
    when "all"
      @pagy, @annotations = pagy(Annotation.random_all)
    when "recent"
      @pagy, @annotations = pagy(Annotation.recent)
    else # only show a random one by default
      @annotations = Annotation.random_single
      
    end
  end

  def show
    @annotation = Annotation.find(params[:id])
  end

  def import
    extracted = extract_highlights(params[:opf_file])
    extracted.each do |e|
      # Rails.logger.debug "Creating #{e['annotation']['highlighted_text']}"
      Annotation.create!(
        highlighted_text: e['annotation']['highlighted_text'],
        notes: e['annotation']['notes'],
        start_cfi: e['annotation']['start_cfi'],
        end_cfi: e['annotation']['end_cfi'],
        timestamp: e['annotation']['timestamp'],
        toc_family_titles: JSON.generate(e['annotation']['toc_family_titles']),
        book_id: params[:book_id]
      )
    end
    redirect_to book_path(params[:book_id])
  end
  
end
