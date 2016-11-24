require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:question) { question = create(:question) }

  describe 'POST #create' do 
    context 'with valid attributes' do
      it 'save answer in database' do 
        expect { post :create, params: {answer: attributes_for(:answer), question_id: question }}.to change(Answer, :count).by(1)
      end
      it 'redirects to show' do
        post :create, params: {answer: attributes_for(:answer), question_id: question}
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end
  end

end