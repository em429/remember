require 'spaced_repetition'

class AnnotationRepetitionsController < ApplicationController

  def update
    @annotation = current_user.annotations.find(params[:id])
    @annotation_repetition = @annotation.annotation_repetition

    @prev_interval = @annotation_repetition.interval
    @prev_ef = @annotation_repetition.easiness_factor

    sm2 = SpacedRepetition::Sm2.new(
      params["annotation_repetition"]["score"].to_i,
      @prev_interval,
      @prev_ef
    )

    @annotation_repetition.update(
      interval: sm2.interval,
      easiness_factor: sm2.easiness_factor,
      next_repetition_date: sm2.next_repetition_date
    )

    @annotation_repetition.save

    # TODO: check if I could set a default parameter for this 'Due Next' redirect
    #redirect_to annotations_path(due: 1, limit: 1)
    redirect_to annotations_path
  end

  private

  def annotation_repetition_params
    params.require(:annotation_repetition).permit(
      %i[score]
    )
  end
  
end
