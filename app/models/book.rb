class Book < ApplicationRecord
  ## Relations
  belongs_to :user
  has_many :annotations, dependent: :destroy

  ## Attachments
  has_one_attached :epub
  has_one_attached :cover

  ## Validations
  # TODO: add more validations
  validates :title, uniqueness: { scope: :author }

  def self.ransackable_associations(auth_object = nil)
    ["annotations"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["author", "created_at", "fiction", "id", "plaintext", "title", "updated_at", "user_id"]
  end  

  def epub_on_disk
    ActiveStorage::Blob.service.path_for(epub.key)
    rescue NoMethodError
      nil
  end

end

