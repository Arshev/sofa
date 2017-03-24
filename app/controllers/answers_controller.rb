class AnswersController < ApplicationController

  include Voted

  before_action :authenticate_user!
  before_action :set_answer, only: [:update, :destroy, :best]
  before_action :set_question, only: [:create, :best]
  after_action :publish_answer, only: [:create]

  respond_to :js
  respond_to :json, only: :create

  authorize_resource
  
  def create
    respond_with(@answer = @question.answers.create(answers_params.merge(user: current_user)))
  end

  def update
    respond_with (@answer.update(answers_params)) if current_user.check_author(@answer)
  end

  def destroy
    @answer.destroy if current_user.check_author(@answer)
    respond_with @answer
  end

  def best
    @answer.set_best if current_user.check_author(@answer)
    respond_with @answer.set_best
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
    gon.question_id = @question.id
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answers_params
    params.required(:answer).permit(:body, :question_id, attachments_attributes: [:file, :id, :_destroy])
  end

  def publish_answer
    return if @answer.errors.any?
    ActionCable.server.broadcast(
      "answers_#{@answer.question_id}",
      @answer
    )
  end
end
