module Api
  class StaffsController < ActionController::API
    before_action :set_staff, only: %i[show update]

    def index
      all = Staff.all.select { |s| s.company_id == current_user.company_id }
      render json: all, status: :ok
    end

    def create
      staff = Staff.new(staff_params)
      staff.company_id = current_user.company_id
      if staff.save
        render json: staff, status: :created
      else
        render json: staff.errors, status: :bad_request
      end
    end

    def show
      if @staff.company_id != current_user.company_id
        render json: nil, status: :no_content
      else
        render json: @staff, status: :ok
      end
    end

    def update
      return render(json: nil, status: :forbidden) if @staff.company_id != current_user.company_id

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
