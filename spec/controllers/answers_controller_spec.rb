require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:question) { question = create(:question) }
  let(:answer) { create(:answer, question: question) }

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

    context 'whith invalid attributes' do
      it 'does not save the question' do
        expect { post :create, params: {answer: attributes_for(:invalid_answer), question_id: question }}.to_not change(Answer, :count)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'delete question' do
      expect { delete :destroy, params: {id: answer.id} }.to change(Answer, :count).by(-1)
    end
  end
end