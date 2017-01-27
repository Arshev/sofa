class AttachmentsController < ApplicationController
  before_action :authenticate_user!, only: [:destroy]
  respond_to :js

  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.destroy if current_user.check_author(@attachment.attachmentable)
  end

end