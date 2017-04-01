require 'rails_helper'

describe 'Profile API' do
  describe 'GET /me' do
    let(:api_path) {'/api/v1/profiles/me'}

    it_behaves_like 'API Authenticable'
  end

  context 'authorized' do
    let(:me) { create(:user) }
    let!(:users) { create_list(:user, 2) }
    let(:access_token) { create(:access_token, resource_owner_id: me.id) }

    before { get '/api/v1/profiles/me', params: {format: :json, access_token: access_token.token} }

    it 'returns 200 status' do
      expect(response).to be_success
    end

    %w(id email created_at updated_at admin).each do |attr|
      it "contains #{attr}" do
        expect(response.body).to be_json_eql(me.send(attr.to_sym).to_json).at_path(attr)
      end
    end

    %w(password encrypted_password).each do |attr|
      it "does not contain #{attr}" do
        expect(response.body).to_not have_json_path(attr)
      end
    end
  end

  describe 'GET /list' do

    let(:api_path) {'/api/v1/profiles/list'}

    it_behaves_like 'API Authenticable'

    context 'authorized' do
      let(:me) { create(:user) }
      let!(:users) { create_list(:user, 2) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }

      before { get '/api/v1/profiles/list', params: { format: :json, access_token: access_token.token } }

      it 'returns all users but me' do
        expect(response.body).to have_json_size(2)

        expect(response.body).to be_json_eql(users.to_json)

        expect(response.body).to_not include_json(me.to_json)
      end
    end
  end
end