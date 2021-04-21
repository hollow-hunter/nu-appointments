class Oauth::AuthorizationsController < Doorkeeper::AuthorizationsController
  before_action :authenticate_user!
end
