class Api::V1::QuestionsController < Api::V1::BaseController

  authorize_resource

  before_action :get_question, only: [:show]

  respond_to :json

  def index
    respond_with(@questions = Question.all)
  end

  def show
    respond_with @question, serializer: SingleQuestionSerializer
  end

  def create
    respond_with @current_resource_owner.questions.create(question_params)
  end

  private

  def get_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end