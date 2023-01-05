class AnnotationsController < ApplicationController
  def index
    @annotations = Annotation.all.order('RANDOM()')
  end
end
