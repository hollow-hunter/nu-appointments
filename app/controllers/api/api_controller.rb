module Api
  class ApiController < ActionController::API
    protected

    def current_user
      @devise_current_user ||= warden.authenticate(scope: :user)
      return @devise_current_user unless @devise_current_user.nil?

      User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end
  end
end
