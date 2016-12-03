require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:question) { create(:question) }
  let(:answer) { answer = create(:answer, question: question) }

  describe 'POST #create' do 
    sign_in_user #modul ControllerMacros
    context 'with valid attributes' do
      it 'save answer in database' do 
        expect { post :create, params: {answer: attributes_for(:answer), question_id: question }}.to change(question.answers, :count).by(1)
      end
    end

    context 'whith invalid attributes' do
      it 'does not save the question' do
        expect { post :create, params: {answer: attributes_for(:invalid_answer), question_id: question }}.to_not change(Answer, :count)
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user #modul ControllerMacros
    before { answer }

    it 'delete answer' do
      expect { delete :destroy, params: { id: answer, question_id: question } }.to change(Answer, :count).by(-1)
    end
  end
end