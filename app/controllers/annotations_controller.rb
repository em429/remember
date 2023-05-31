class AnnotationsController < ApplicationController

  def show
    @annotation = current_user.annotations.find(params[:id])
  end

end
