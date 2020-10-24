class ErrorsController < ApplicationController
  before_action :authenticate_user!, except: %i[not_found internal_error]

  def not_found
    render status: :not_found
  end

  def internal_error
    render status: :internal_server_error
  end
end
