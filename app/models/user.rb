class User < ApplicationRecord
  has_secure_password

  ## Relations
  has_many :books, dependent: :destroy
  has_many :annotations, through: :books

  ## Callbacks
  before_save do
    self.email = email.downcase
    self.username = username.downcase
  end
  
  ## Validations
  validates :username, presence: true
  validates :email, presence: true,
                    format: { with: /\S+@\S+/ },
                    uniqueness: { case_sensitive: false }
  
end
