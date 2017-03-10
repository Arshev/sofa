class AnswersController < ApplicationController

  include Voted

  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_question, only: [:create, :destroy, :best]
  before_action :set_answer, only: [:update, :destroy, :best]
  after_action :publish_answer, only: [:create]
  
  def create
    @answer = @question.answers.create(answers_params)
    @answer.user = current_user
    @answer.save
  end

  def update
    @answer.update(answers_params) if current_user.check_author(@answer)
    @question = @answer.question
  end

  def destroy
    @answer.destroy if current_user.check_author(@answer)
  end

  def best
    @answer.set_best if current_user.check_author(@answer)
    @question = @answer.question    
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answers_params
    params.required(:answer).permit(:body, attachments_attributes: [:file, :id, :_destroy])
  end

  def publish_answer
    return if @answer.errors.any?
    ActionCable.server.broadcast(
      'answers',
      ApplicationController.render(
        json: @answer
      )
    )
  end
end
