require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

  let!(:question) { create(:question) }

  describe 'PATCH #vote_up' do    

    context 'when user votes for someones question' do

      sign_in_user
      before { patch :vote_up, params: {id: question} }

      it 'increase rating by 1' do
        result = {"rating":1, "vote":1}.to_json
        expect(response.body).to eq(result)
      end

      it 'responds with json' do
        expect(response.content_type).to eq('application/json')
      end

      it 'save vote to db' do
        resp = JSON.parse(@response.body)
        expect(resp["vote"]).to eq(Vote.first.value)
      end
    end
    context 'when user votes for own question' do
      let(:users_record) { create(:question, user: @user) }
      sign_in_user
      before { patch :vote_up, params: {id: question} }
      it 'increase rating by 0' do
        result = {"rating":0, "vote":0}.to_json
        expect(response.body).to eq(result)
      end
    end
  end

  describe 'PATCH #vote_down' do    

    context 'when user votes for someones question' do

      sign_in_user
      before { patch :vote_down, params: {id: question} }

      it 'increase rating by 1' do
        result = {"rating": -1, "vote": -1}.to_json
        expect(response.body).to eq(result)
      end

      it 'responds with json' do
        expect(response.content_type).to eq('application/json')
      end

      it 'save vote to db' do
        resp = JSON.parse(@response.body)
        expect(resp["vote"]).to eq(Vote.first.value)
      end
    end

    context 'when user votes for own question' do
      let(:users_record) { create(:question, user: @user) }
      sign_in_user
      before { patch :vote_down, params: {id: question} }
      it 'increase rating by 0' do
        result = {"rating":0, "vote":0}.to_json
        expect(response.body).to eq(result)
      end
    end
  end
end