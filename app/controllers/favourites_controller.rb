class FavouritesController < ApplicationController
  before_action :authenticate_user

  def create
    fav          = current_user.favourites.new
    question     = Question.find params[:question_id]
    # fav.user     = current_user
    fav.question = question
    if fav.save
      redirect_to question_path(question), notice: "Favourited!"
    else
      redirect_to question_path(question), alert: "Error occured!"
    end
  end

  def destroy
    question = Question.find params[:question_id]
    fav      = current_user.favourites.find params[:id]
    fav.destroy
    redirect_to question_path(question), notice: "UnFavourited!"
  end

end
