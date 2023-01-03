class Book < ApplicationRecord
  has_many :annotations
  has_one_attached :epub
end
