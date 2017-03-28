class Api::V1::QuestionsController < Api::V1::BaseController

  before_action :doorkeeper_authorize!

  # authorize_resource class: User

  respond_to :json

  def index
    respond_with(@questions = Question.all)
  end
end