require 'rails_helper'

describe 'Answers API' do
  describe 'GET /index' do
    let!(:question) { create(:question) }
    let(:api_path) {"/api/v1/questions/#{question.id}/answers"}

    it_behaves_like 'API Authenticable'

    context 'authorized' do
      let(:access_token) { create(:access_token) }
      let!(:answers) { create_list(:answer, 2, question: question) }

      before { get "/api/v1/questions/#{question.id}/answers", params: { format: :json, access_token: access_token.token } }

      it 'responds with code 200' do
        expect(response.status).to eq(200)
      end

      it 'returns answers list' do
        expect(response.body).to have_json_size(2).at_path('answers')
      end

      context 'each answer object' do
        %w(id body created_at updated_at).each do |attr|
          it "contains attribute #{attr}" do
            answer = answers.first
            expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("answers/0/#{attr}")
          end
        end
      end
    end
  end

  describe 'GET /show' do
    let(:answer) { create(:answer) }
    let!(:attachment) { create(:attachment, attachmentable: answer) }
    let!(:comment) { create(:comment, commentable: answer) }
    let(:access_token) { create(:access_token) }
    let(:api_path) {"/api/v1/answers/#{answer.id}"}
    let(:attachmentable) { answer }
    let(:commentable) { answer }

    it_behaves_like 'API Authenticable'

    it_should_behave_like 'API attachments'

    it_should_behave_like 'API comments'

    context 'authorized' do

      before { get api_path, params: { format: :json, access_token: access_token.token } }

      it 'responds with code 200' do
        expect(response.status).to eq(200)
      end

      %w(id body created_at updated_at user_id).each do |attr|
        it "contains attribute #{attr}" do
          expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("answer/#{attr}")
        end
      end
    end
  end

  describe 'POST /create' do
    let!(:question) { create(:question) }

    context 'unauthorized' do
      context 'when request does not have access_token' do
        it 'responds with code 401' do
          post "/api/v1/questions/#{question.id}/answers",
               params: { format: :json, question_id: question, answer: attributes_for(:answer) }
          expect(response.status).to eq(401)
        end

        it 'does not save answer to db' do
          expect{ post "/api/v1/questions/#{question.id}/answers", params: { format: :json, question_id: question, answer: attributes_for(:answer) } }.to_not change(Answer, :count)
        end
      end

      context 'when access_token is invalid' do
        it 'responds with code 401' do
          post "/api/v1/questions/#{question.id}/answers", params: { format: :json, access_token: '123456', question_id: question, answer: attributes_for(:answer) }
          expect(response.status).to eq(401)
        end

        it 'does not save answer to db' do
          expect { post "/api/v1/questions/#{question.id}/answers", params: { format: :json, access_token: '123456', question_id: question, answer: attributes_for(:answer) } }.to_not change(Answer, :count)
        end
      end
    end

    context 'authorized' do
      let(:user) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: user.id) }

      context 'with valid attributes' do
        it 'responds with code 201' do
          post "/api/v1/questions/#{question.id}/answers",
               params: { format: :json, access_token: access_token.token, question_id: question, answer: attributes_for(:answer) }
          expect(response.status).to eq(201)
        end

        it 'saves new question to db' do
          expect { post "/api/v1/questions/#{question.id}/answers", params: { format: :json, access_token: access_token.token, question_id: question, answer: attributes_for(:answer) } }.to change(user.answers.where(question: question), :count).by(1)
        end
      end

      context 'with invalid attributes' do
        it 'responds with code 422' do
          post "/api/v1/questions/#{question.id}/answers", params: { format: :json, access_token: access_token.token, question_id: question, answer: attributes_for(:invalid_answer) }
          expect(response.status).to eq(422)
        end

        it 'does not save new question to db' do
          expect { post "/api/v1/questions/#{question.id}/answers", params: { format: :json, access_token: access_token.token, question_id: question, answer: attributes_for(:invalid_answer) } }.to_not change(Answer, :count)
        end
      end
    end
  end
end