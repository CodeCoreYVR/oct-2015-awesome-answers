class LikesMailer < ApplicationMailer

  def notify_question_owner(like)
    @like     = like
    @question = @like.question
    @owner    = @question.user
    if @owner.email.present?
      mail(to: @owner.email, subject: "You've got a new like!")
    end
  end

end
