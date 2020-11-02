module Api
  class AppointmentsController < ActionController::API
    before_action :set_appointment, only: %i[edit update show]

    def index
      render json: Appointment.all, status: :ok
    end

    def create
      a = Appointment.new(appointment_params)
      if a.save
        render json: a, status: :created, location: api_appointment_path(a)
      else
        render json: a.errors, status: :bad_request
      end
    end

    def update
      if @appointment.update(appointment_params)
        render json: :show, status: :ok, location: api_appointment_path(@appointment)
      else
        render json: @appointment.errors, status: :bad_request
      end
    end

    def show
      render json: @appointment, status: :ok
    end

    private

    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    def appointment_params
      params.permit(:id, :date, :start_time, :end_time, :client_id, :staff_id, :status)
    end
  end
end
