class Question < ActiveRecord::Base

  # when using has_many :answers we expect that we have a model named Answer
  # we use the dependent option maintain referential integrity, we have two options:
  # 1. use {dependent: :destroy} this will destroy all answers referecing a
  #    a question just before deleting the question
  # 2. use {dependent: :nullify} this will make `question_id` value for all
  #    answers referencing a question `null` before deleting the question.
  has_many(:answers, {dependent: :destroy})

  has_many :likes, dependent: :destroy
  # has_many :users, through: :likes
  has_many :liking_users, through: :likes, source: :user

  has_many :favourites, dependent: :destroy
  has_many :favouriting_users, through: :favourites, source: :user

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  has_many :votes, dependent: :destroy
  has_many :voting_users, through: :votes, source: :user

  belongs_to :user

  mount_uploader :image, ImageUploader

  validates(:title, {presence:   true,
                     uniqueness: {message: "was used already"},
                     length:     {minimum: 3}})
  validates :body, presence:   true,
                   uniqueness: {scope: :title}
                   # using scope: :title will make sure that the body is unique
                   # in combination with the title

  validates :view_count, numericality: {greater_than_or_equal_to: 0}

  # VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  # validates :email, format: VALID_EMAIL_REGEX

  validate :no_monkey

  after_initialize :set_default_values

  before_validation :capitalize_title

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  # scope(:recent_ten, lambda { order("created_at DESC").limit(10) })
  def self.recent_ten
    order("created_at DESC").limit(10)
  end

  def self.recent(num_records)
    order("created_at DESC").limit(num_records)
  end

  def self.search(term)
    if term == ""
      "You must enter a search term"
    else
      # where(["title ILIKE :search_term OR body ILIKE :search_term",
      #         {search_term: "%#{term}%"}])
      where(["title ILIKE ? OR body ILIKE ?", "%#{term}%", "%#{term}%"])
    end
  end

  def liked_by?(user)
    # likes.find_by_user_id(user.id).present?
    like_for(user).present?
  end

  def like_for(user)
    likes.find_by_user_id(user.id)
  end

  def favourited_by?(user)
    favourite_for(user).present?
  end

  def favourite_for(user)
    favourites.find_by_user_id user.id
  end

  def voted_on_by?(user)
    vote_for(user).present?
  end

  def vote_for(user)
    votes.find_by_user_id user.id
  end

  def vote_result
    votes.select {|v| v.is_up? }.count - votes.select {|v| !v.is_up? }.count
  end

  # def to_param
  #   id
  # end
  #
  # def to_param
  #   "#{id}-#{title}".parameterize
  # end

  private

  # this is a custom validation method
  def no_monkey
    if title.present? && title.downcase.include?("monkey")
      errors.add(:title, "No monkeys please!")
    end
  end

  def set_default_values
    self.view_count ||= 0
  end

  def capitalize_title
    self.title.capitalize! if title
  end

end
