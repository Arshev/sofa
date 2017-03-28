class Api::V1::BaseController < ApplicationController

  before_action :doorkeeper_authorize!

  # authorize_resource class: User

  respond_to :json
  
  protected

  def current_resource_owner
    @current_resource_owner ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

  # def other_users
  #   @users = User.where.not(id: current_resource_owner.id) if current_resource_owner
  # end

  # def current_ability
  #   @ability ||= Ability.new(current_resource_owner)
  # end
end