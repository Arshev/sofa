class Api::V1::AnswersController < Api::V1::BaseController

  authorize_resource

  before_action :get_answer, only: [:show]
  before_action :get_question, only: [:index, :create]

  def index
    respond_with @question.answers
  end

  def show
    respond_with @answer, serializer: SingleAnswerSerializer
  end

  def create
    respond_with @question.answers.create(answer_params)
  end

  private

  def get_answer
    @answer = Answer.find(params[:id])
  end

  def get_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body).merge(user: @current_resource_owner)
  end
end