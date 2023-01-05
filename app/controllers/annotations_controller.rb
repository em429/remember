class AnnotationsController < ApplicationController
  def index
    @annotations = Annotation.all.order('RANDOM()')
  end

  def show_random
    @annotation = Annotation.all.order('RANDOM()').limit(1).first
  end
end
