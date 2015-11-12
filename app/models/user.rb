class User < ActiveRecord::Base
  # http://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html#method-i-has_secure_password
  has_secure_password

  # attr_accessor :hello

  has_many :questions, dependent: :nullify
  has_many :answers, dependent: :nullify

  has_many :likes, dependent: :destroy
  has_many :liked_questions, through: :likes, source: :question

  has_many :favourites, dependent: :nullify
  has_many :favourite_questions, through: :favourites, source: :question

  validates :email, presence: true, uniqueness: true

  def full_name
    "#{first_name} #{last_name}".strip
  end
end
