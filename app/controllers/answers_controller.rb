class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_question, only: [:create, :destroy, :answer_best]
  before_action :set_answer, only: [:update, :destroy, :answer_best]
  
  def create
    @answer = @question.answers.create(answers_params)
    @answer.user = current_user
    @answer.save
  end

  def update
    @answer.update(answers_params)
    @question = @answer.question
  end

  def destroy
    @answer.destroy if current_user.check_author(@answer)
  end

  def answer_best
    @question = @answer.question
    @answer.set_best if current_user.check_author(@answer)
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answers_params
    params.required(:answer).permit(:body)
  end
end
