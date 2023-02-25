class Book < ApplicationRecord
  ## Relations
  belongs_to :user
  has_many :annotations, dependent: :destroy

  ## Attachments
  has_one_attached :epub
  has_one_attached :cover
  
  def epub_on_disk
    ActiveStorage::Blob.service.path_for(epub.key)
    rescue NoMethodError
      nil
  end

end

