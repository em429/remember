class AnnotationsController < ApplicationController
  def index
    @annotations = Annotation.all
  end
end
