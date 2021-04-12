module Api
  class AppointmentsController < ApiController
    before_action :set_appointment, only: %i[edit update show]
    before_action :check_authorization!

    def index
      appointments = Appointment.all.select { |a| a.staff.company_id == current_user.company_id }
      render json: appointments, status: :ok
    end

    def create
      a = Appointment.new(appointment_params)
      if a.check_company(current_user.company_id) && a.save
        ClientMailer.appointment_created(a.client, a).deliver_later if params[:notify]
        render json: a, status: :created, location: api_appointment_path(a)
      else
        render json: a.errors, status: :bad_request
      end
    end

    def update
      return render(json: nil, status: :forbidden) if @appointment.staff.company_id != current_user.company_id

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
