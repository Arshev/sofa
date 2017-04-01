shared_examples_for "API Authenticable" do
  context 'unauthorized' do
    it 'responds with code 401 if request does not have access_token' do
      get api_path, params: { format: :json }
      expect(response.status).to eq(401)
    end

    it 'responds with code 401 if access_token is invalid' do
      get api_path, params: { format: :json, access_token: '123456' }
      expect(response.status).to eq(401)
    end
  end
end