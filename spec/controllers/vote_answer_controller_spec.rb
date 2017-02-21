require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let!(:question) { create(:question) }
  let!(:answer) { create(:answer, question: question) }

  describe 'PATCH #vote_up' do    

    context 'when user votes for someones answer' do

      sign_in_user
      before { patch :vote_up, params: {id: answer} }

      it 'increase rating by 1' do
        hh = {"rating":1, "vote":1}.to_json
        expect(response.body).to eq(hh)
      end

      it 'responds with json' do
        expect(response.content_type).to eq('application/json')
      end

      it 'save vote to db' do
        resp = JSON.parse(@response.body)
        expect(resp["vote"]).to eq(Vote.first.value)
      end
    end
    context 'when user votes for own answer' do
      let(:users_record) { create(:answer, user: @user) }
      sign_in_user
      before { patch :vote_up, params: {id: answer} }
      it 'increase rating by 0' do
        hh = {"rating":0, "vote":0}.to_json
        expect(response.body).to eq(hh)
      end
    end
  end

  describe 'PATCH #vote_down' do    

    context 'when user votes for someones answer' do

      sign_in_user
      before { patch :vote_down, params: {id: answer} }

      it 'increase rating by 1' do
        hh = {"rating": -1, "vote": -1}.to_json
        expect(response.body).to eq(hh)
      end
    end
  end
end