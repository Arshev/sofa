require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  describe 'DELETE #destroy' do
    sign_in_user
    let!(:question){ create :question }

    before do
      question.attachments.create!(file: File.open("#{Rails.root}/spec/spec_helper.rb"))
    end

    context 'Delete by author' do
      before { question.update(user_id: @user.id) }

      it 'Delete attachment' do
        expect { delete :destroy, params: { id: question.attachments.first }, format: :js }.to change(Attachment, :count).by(-1)
      end
    end

    context 'Delete not author' do
      it 'does not delete attachment' do
        expect { delete :destroy, params: { id: question.attachments.first }, format: :js }.to_not change(Attachment, :count)
      end
    end
  end
end