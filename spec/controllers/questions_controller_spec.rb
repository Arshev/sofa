require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

  let!(:question) { create(:question) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 2) }

    before { get :index }

    it 'populates an array of all questions' do 
      expect(assigns(:questions)).to match_array(Question.all)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end

  end

  describe 'GET #show' do 
    before { get :show, params: {id: question} }

    it 'assigns the requested question to @question' do 
      expect(assigns(:question)).to eq question
    end

    it 'assigns new answer for question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'builds new attachment for answer' do
      expect(assigns(:answer).attachments.first).to be_a_new(Attachment)
    end

    it 'renders show view' do 
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    sign_in_user #modul ControllerMacros

    before { get :new }

    it 'assigns a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'builds new attachments for question' do
      expect(assigns(:question).attachments.first).to be_a_new(Attachment)
    end

    it 'render new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    sign_in_user #modul ControllerMacros
    before { get :edit, params: {id: question} }

    it 'assigns the requested question to @question' do 
      expect(assigns(:question)).to eq question
    end

    it 'render edit view' do
      expect(response).to render_template :edit
    end

  end

  describe 'POST #create' do 
    sign_in_user #modul ControllerMacros
    context 'with valid attributes' do
      it 'save the new question in the database' do 
        expect { post :create, params: {question: attributes_for(:question)} }.to change(Question, :count).by(1)
      end

      it 'associates current user with question' do
        post :create, params: {question: attributes_for(:question)}
        expect(assigns(:question).user_id).to eq @user.id
      end

      it 'redirect to create view' do 
        post :create, params: {question: attributes_for(:question)}

        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid attributes' do 
      it 'does not save the question' do 
        expect { post :create, params: {question: attributes_for(:invalid_question)} }.to_not change(Question, :count)
      end

      it 're-render new view' do
        post :create, params: {question: attributes_for(:invalid_question)}
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do 
    sign_in_user #modul ControllerMacros
    context 'update author with valid attributes' do
      before { sign_in question.user }

      it 'assigns the requested question to @question' do 
        patch :update, params: {id: question, question: attributes_for(:question), format: :js }
        expect(assigns(:question)).to eq question
      end

      it 'changes question attributes' do
        patch :update, params: {id: question, question: {title: 'new title', body: 'new body'}, format: :js }
        question.reload
        expect(question.title).to eq 'new title'        
        expect(question.body).to eq 'new body'
      end

      it 'render update templete' do
        patch :update, params: {id: question, question: attributes_for(:question), format: :js }
        expect(response).to render_template :update
      end
    end

    context 'update author with invalid attributes' do
      before { sign_in question.user }

      before { patch :update, params: {id: question, question: {title: 'new title', body: nil }, format: :js } }

      it 'does not change question attributes' do
        question.reload
        expect(question.title).to_not eq 'new title'        
        expect(question.body).to_not eq nil        
      end

      it 're-render edit view' do
        expect(response).to render_template :update
      end
    end

    context 'update not author' do
      it 'changes question attributes' do
        patch :update, params: {id: question, question: {title: 'new title', body: 'new body'}, format: :js }
        question.reload
        expect(question.title).to_not eq 'new title'        
        expect(question.body).to_not eq 'new body'
      end

      it 'render update template' do
        patch :update, params: {id: question, question: attributes_for(:question), format: :js }
        expect(response).to render_template :update
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:delete_action) { delete :destroy, params: {id: question} }
    before { question }
    
    context 'delete author' do
      before { sign_in question.user }
      
      it 'delete question' do
        expect { delete_action }.to change(Question, :count).by(-1)
      end

      it 'redirect to questions' do
        delete_action
        expect(response).to redirect_to questions_path
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
