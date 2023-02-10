class Book < ApplicationRecord
  has_many :annotations, dependent: :destroy
  has_one_attached :epub
  has_one_attached :cover
  
  def epub_on_disk
    ActiveStorage::Blob.service.path_for(epub.key)
  end

end

