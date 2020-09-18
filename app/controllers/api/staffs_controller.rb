module Api
  class StaffsController < ActionController::API
    def index
      all = Staff.all
      render json: all
    end
  end
end
