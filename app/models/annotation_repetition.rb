class AnnotationRepetition < ApplicationRecord
  belongs_to :annotation
  # TODO add validations

  def self.ransackable_attributes(auth_object = nil)
    ["annotation_id", "created_at", "easiness_factor", "id", "interval", "next_repetition_date", "updated_at"]
  end  

end
