class VotesController < ApplicationController
  before_action :authenticate_user

  def create
    question      = Question.find params[:question_id]
    # this will instantiate a vote object pre-associated with the current_user
    # which means `vote` will have a `user_id` value equivalent to current_user.id
    vote          = current_user.votes.new vote_params
    vote.question = question
    if vote.save
      redirect_to question_path(question), notice: "voted!"
    else
      redirect_to question_path(question), alert: "can't vote!"
    end
  end

  def destroy
  end

  def update
  end

  private

  def vote_params
    params.require(:vote).permit(:is_up)
  end
end
