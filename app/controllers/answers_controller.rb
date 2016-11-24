class AnswersController < ApplicationController
  before_action :set_question, only: [:create]
  
  def create
    @answer = @question.answers.new(answers_params)
    if @answer.save
    redirect_to @question
    else
      render :new
    end
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def answers_params
    params.required(:answer).permit(:body)
  end
end
