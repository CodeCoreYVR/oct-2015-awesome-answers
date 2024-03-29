# the convention in Rails is to use pluralize model name if the controller
# is related to that model. For instance, if the model name is Question
# the controller name should be QuestionsController
# you can generate such controller by running:
# bin/rails g controller questions
class QuestionsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]

  # layout "special"

  # before action will register a method (in this case it's called find_question)
  # that will be executed before all actions unless you specify options such as:
  # :except or :only
  # before_action(:find_question, {except: [:index, :new, :create]})
  before_action(:find_question, {only: [:show, :edit, :update, :destroy]})

  # we usually use the word `authenticate` to refer to signing in or out with
  # email and password. We use the word `authorize` to refer to enforcing
  # permissions for specific actions.
  before_action :authorize, only: [:edit, :update, :destroy]

  def new

    # the default behaviour of controller action is to render a template
    # within a folder with the same controller name. Using the format/templating
    # language used. In this case we're using the default format which is HTML
    # we are using the default templating language which is ERB
    # So the controller action will render template:
    # views/questions/new.html.erb
    @q = Question.new
  end

  def create
    @q      = Question.new(question_params)
    @q.user = current_user
    if @q.save
      # render text: "Saved correctly!"
      # redirect_to(question_path({id: @q.id}))
      # can be shortened to:
      redirect_to(question_path(@q), notice: "Question created!")
    else
      # render text: "Didn't save correctly! #{q.errors.full_messages.join(", ")}"
      render :new
    end
  end

  # GET /questions/:id
  # you get access to the id in the URL from params[:id]
  def show
    # we insantiate an empty Answer object as we need a form on the show page
    # to create an answer for our question
    @answer = Answer.new
    # default: render: views/questions/show.html.erb

    # render :show, layout: "special"
    respond_to do |format|
      format.html { render }
      format.json { render json: @q.to_json }
    end
  end

  def edit
    redirect_to root_path, alert: "Access denied." unless can? :edit, @q
  end

  def update
    # this will make friendly id regenerate a slug for you
    @q.slug = nil
    if @q.update(question_params)
      redirect_to question_path(@q), notice: "Question updated!"
    else
      render :edit
    end
  end

  def index
    # QuestionsCleanupJob.perform_later
    Rails.logger.error ">>>>>>>>>> #{current_user}"
    @questions = Question.recent_ten
    # Rails by default will render views/questions/index.html.erb
    respond_to do |format|
      format.html { render }
      format.json { render json: @questions.select(:id, :title, :view_count).to_json }
    end
  end

  def destroy
    @q.destroy
    flash[:notice] = "Question deleted successfully"
    redirect_to questions_path
  end

  private

  def question_params
    # params[:question] #  "question"=>{"title"=>"abc", "body"=>"xyz"}
    # Question.create({title: params[:question][:title],
    #                  body:  params[:question][:body]})
    # Mass assignment way:
    params.require(:question).permit([:title, :body, {tag_ids: []}, :image])
    # {tag_ids: []} this permits that tag_ids contains an array of values
    # instead of a single value.
  end

  def find_question
    # finding the question by its id
    @q = Question.friendly.find params[:id]
    # this will redirect the user to the new url (with new slug) if friednly
    # id found the question using an old slug
    # redirect_to @q if @q.slug != params[:id]
  end

  def authorize
    redirect_to root_path, alert: "Access denied!" unless can? :manage, @q
  end

end
