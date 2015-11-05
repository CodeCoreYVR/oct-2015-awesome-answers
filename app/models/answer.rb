class Answer < ActiveRecord::Base
  # belongs_to gives the Answer class two methods a getter and setter to
  # associate a speicific answer with a question.
  # For instance, to find a question for a given answer:
  # a = Answer.find 1
  # q = a.question # this returns a question object whose `id` is `a.question_id`
  # to set a question for a given answer:
  # a = Answer.new({body: "Abc"})
  # q = Question.find(100)
  # a.question = q
  # a.save
  belongs_to :question

  belongs_to :user

  validates :body, presence: true
end
