# the convention in Rails is to use pluralize model name if the controller
# is related to that model. For instance, if the model name is Question
# the controller name should be QuestionsController
# you can generate such controller by running:
# bin/rails g controller questions
class QuestionsController < ApplicationController

  def new
    # the default behaviour of controller action is to render a template
    # within a folder with the same controller name. Using the format/templating
    # language used. In this case we're using the default format which is HTML
    # we are using the default templating language which is ERB
    # So the controller action will render template:
    # views/questions/new.html.erb
  end

  def create
    render text: "Inside Questions Create"
  end
end
