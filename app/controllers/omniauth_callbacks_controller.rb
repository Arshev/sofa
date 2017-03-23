class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  before_action :set_auth
  before_action :authorization_auth

  def facebook
  end

  def twitter
  end

  def vkontakte
  end

  private

  def set_auth
    @auth = request.env['omniauth.auth']
  end

  def authorization_auth
    @user = User.find_for_oauth(@auth) 
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: @auth.provider.capitalize) if is_navigational_format?
    else
      set_flash_message(:notice, :failure, kind: @auth.provider.capitalize) if is_navigational_format?
    end
  end
end