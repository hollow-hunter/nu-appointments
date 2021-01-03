class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_company_user

  def index; end

  def new; end
end
