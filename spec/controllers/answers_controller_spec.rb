require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:question) { create(:question) }
  let!(:answer) { create(:answer, question: question) }

  describe 'POST #create' do 
    sign_in_user #modul ControllerMacros
    context 'with valid attributes' do
      it 'save answer in database' do 
        expect { post :create, params: { answer: attributes_for(:answer), question_id: question } }.to change(Answer, :count).by(1)
      end
    end

    context 'whith invalid attributes' do
      it 'does not save the question' do
        expect { post :create, params: {answer: attributes_for(:invalid_answer), question_id: question }}.to_not change(Answer, :count)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:delete_action) { delete :destroy, params: {question_id: answer.question.id, id: answer} }
    
    context 'delete author' do 
      before { sign_in answer.user }
      
      it 'delete answer' do
        expect { delete_action }.to change(Answer, :count).by(-1)
      end
    end

    context 'delete not author' do
      sign_in_user
      it 'does not delete question' do
        expect { delete_action }.not_to change(Question, :count)
      end
    end
  end
end