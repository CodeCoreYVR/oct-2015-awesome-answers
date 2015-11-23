class AnswersController < ApplicationController
  before_action :authenticate_user

  def create
    answer_params    = params.require(:answer).permit(:body)
    # params[:question_id] is coming from the URL which looks like:
    # /questions/98/answers
    @q               = Question.friendly.find params[:question_id]
    # this will insnatiate the Answer object with user_id prepopulated with
    # current_user.id
    @answer          = current_user.answers.new(answer_params)
    # this associates the @answer with question `q`
    @answer.question = @q
    # byebug
    respond_to do |format|
      if @answer.save
        AnswersMailer.notify_question_owner(@answer).deliver_later
        # redirect_to(question_path(q), {notice: "Answer created successfully!"})
        format.html { redirect_to question_path(@q), notice: "Answer created successfully!" }
        # this will render views/answers/create_success.js.erb
        format.js { render :create_success }
      else
        # flash[:alert] = @answer.errors.full_messages.join(", ")
        format.html { render "questions/show" }
        format.js   { render :create_failure }
      end
    end
  end

  def destroy
    @answer = Answer.find params[:id]
    redirect_to root_path, alert: "access denied!" unless can?(:destroy, @answer)
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to question_path(@answer.question), notice: "Answer deleted" }
      format.js   { render } # this renders /views/answers/destroy.js.erb
    end
  end

end
