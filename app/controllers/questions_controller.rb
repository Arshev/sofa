class QuestionsController < ApplicationController

  include Voted

  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :load_question, only: [:show, :edit, :update, :destroy]
  before_action :build_answer, only: :show
  after_action :publish_question, only: [:create]
  
  def index
    @questions = Question.all
  end

  def show
    @answer.attachments.build
  end

  def new
    @question = current_user.questions.new
    @question.attachments.build
  end

  def edit
  end

  def create
    @question = current_user.questions.create(question_params)
    if @question.save
      redirect_to @question, notice: 'Add question success'
    else
      render :new
    end
  end

  def update
    @question.update(question_params) if current_user.check_author(@question)
  end

  def destroy
    if current_user.check_author(@question)
      @question.destroy
      redirect_to questions_path
    else
      redirect_to @question
    end
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
        partial: 'questions/question',
        locals: { question: @question }
      )
    )
  end
end
