class User < ApplicationRecord
  has_secure_password

  ## Relations
  has_many :books, dependent: :destroy
  has_many :annotations, through: :books
  has_many :flashcards, through: :annotations

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
  
  PASSWORD_REQUIREMENTS = /\A
    (?=.{8,}) # At least 8 characters long
    (?=.*\d) # At least one number
    (?=.*[a-z]) # At least one lowercase
  /x
  validates :password, format: {
    with: PASSWORD_REQUIREMENTS,
    message: 'must be 8+ characters and must include a number'
  }
  
end
