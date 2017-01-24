class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:destroy]
  before_action :load_attachment
  respond_to :js

  def destroy
    @attachment.destroy if current_user.check_author(@attachment.attachable)
  end

  private

  def load_attachment
    @attachment = Attachment.find(params[:id])
  end

end