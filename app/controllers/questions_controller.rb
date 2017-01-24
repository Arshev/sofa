class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :load_question, only: [:show, :edit, :update, :destroy]
  before_action :build_answer, only: :show
  
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
  end

  def build_answer
    @answer = @question.answers.new
  end

  def question_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:file, :id, :done, :_destroy])
  end
end
