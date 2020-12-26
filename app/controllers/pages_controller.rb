class PagesController < ApplicationController
  def index
    @company = Company.find(current_user.company_id) if user_signed_in? && !current_user.company_id.nil?
  end
end
