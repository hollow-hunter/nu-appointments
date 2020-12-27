class ApplicationController < ActionController::Base
  protected

  def check_company_user
    redirect_to root_path if current_user.company_id.nil?
  end
end
