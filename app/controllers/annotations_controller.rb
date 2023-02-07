#require 'converters'

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
    metadata_hashes = calibre_metadata_to_json(params[:opf_file])
    metadata_hashes.each do |hash|
      annotation_hash = hash['annotation']
      Annotation.create!(
        highlighted_text: annotation_hash['highlighted_text'],
        notes: annotation_hash['notes'],
        start_cfi: annotation_hash['start_cfi'],
        end_cfi: annotation_hash['end_cfi'],
        timestamp: annotation_hash['timestamp'],
        toc_family_titles: JSON.generate(annotation_hash['toc_family_titles']),
        book_id: params[:book_id]
      )
    end
    redirect_to book_path(params[:book_id])
  end
  
end
