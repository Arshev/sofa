require 'rails_helper'

RSpec.describe OmniauthCallbacksController, type: :controller do

  ['Facebook', 'Twitter'].each do |provider|
    describe "GET ##{provider.downcase.to_sym}" do
      context 'if auth valid' do
        before do
          @request.env["omniauth.auth"] = mock_auth_hash(provider)
          @request.env["devise.mapping"] = Devise.mappings[:user]
          get :facebook
        end

        it 'assigns user' do
          expect(assigns(:user).email).to eq('user@example.com')
        end

        it 'sets flash message' do
          expect(controller).to set_flash[:notice]
        end

        it 'redirects to root' do
          expect(response).to redirect_to root_path
        end
      end
    end
  end
end