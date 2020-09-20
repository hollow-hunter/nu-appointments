module Api
  class StaffsController < ActionController::API
    def index
      all = Staff.all
      render json: all
    end

    def create
      staff = Staff.new(staff_params)
      if staff.save
        render json: staff, status: :created
      else
        render json: staff.errors, status: :bad_request
      end
    end

    private

    def staff_params
      params.permit(:name)
    end
  end
end
