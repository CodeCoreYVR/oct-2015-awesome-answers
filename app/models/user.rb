class User < ActiveRecord::Base
  # http://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html#method-i-has_secure_password
  has_secure_password

  # attr_accessor :hello

  has_many :questions, dependent: :nullify

  # this is the answers created by this user
  has_many :answers, dependent: :nullify

  # this will give all the answers on the questions created by the user
  # user -- created many -- > questions -- has many --> answers (could be
  # created by this user or any other user)
  has_many :questions_answers, through: :questions, source: :answers

  has_many :likes, dependent: :destroy
  has_many :liked_questions, through: :likes, source: :question

  has_many :favourites, dependent: :nullify
  has_many :favourite_questions, through: :favourites, source: :question

  has_many :votes, dependent: :nullify
  has_many :voted_questions, through: :votes, source: :question

  validates :email, presence: true, uniqueness: true

  def full_name
    "#{first_name} #{last_name}".strip
  end
end
