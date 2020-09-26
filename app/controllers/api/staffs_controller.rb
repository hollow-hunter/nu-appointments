module Api
  class StaffsController < ActionController::API
    before_action :set_staff, only: %i[show update]

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

    def show
      render json: @staff, status: :ok
    end

    def update
      if @staff.update(staff_params)
        render json: @staff, status: :ok
      else
        render json: @staff.errors, status: :bad_request
      end
    end

    private

    def set_staff
      @staff = Staff.find(params[:id])
    end

    def staff_params
      params.permit(:name)
    end
  end
end
