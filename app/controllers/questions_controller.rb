class QuestionsController < ApplicationController

  include Voted

  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :load_question, only: [:show, :edit, :update, :destroy]
  before_action :build_answer, only: :show
  after_action :publish_question, only: [:create]

  respond_to :js, :json
  
  def index
    respond_with (@questions = Question.all)
  end

  def show
    respond_with @question
  end

  def new
    respond_with (@question = current_user.questions.new)
  end

  def edit
  end

  def create
    respond_with (@question = current_user.questions.create(question_params))
  end

  def update
    @question.update(question_params) if current_user.check_author(@question)
    respond_with @question
  end

  def destroy
    @question.destroy if current_user.check_author(@question)
    respond_with @question
  end

  private

  def load_question
    @question = Question.find(params[:id])
    gon.question_id = @question.id
  end

  def build_answer
    @answer = @question.answers.new
  end

  def question_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:file, :id, :_destroy])
  end

  def publish_question
    return if @question.errors.any?
    ActionCable.server.broadcast(
      'questions',
      ApplicationController.render(
        partial: 'questions/question_part',
        locals: { question: @question }
      )
    )
  end
end
