module Api
  class ClientsController < ApiController
    before_action :set_client, only: %i[show update]
    before_action :check_authorization!
    def index
      clients = Client.all.select { |c| c.company_id == current_user.company_id }
      render json: clients, status: :ok
    end

    def create
      client = Client.new client_params
      client.company_id = current_user.company_id
      if client.save
        render json: client, status: :created
      else
        render json: client.errors, status: :bad_request
      end
    end

    def show
      render json: @client, status: :ok
    end

    def update
      if @client.update(client_params)
        render json: @client, status: :ok
      else
        render json: @client.errors, status: :bad_request
      end
    end

    def code
      client = Client.find_by_code(params[:code])
      if client.nil?
        head :no_content
      else
        render json: client, status: :ok
      end
    end

    private

    def set_client
      @client = Client.find(params[:id])
    end

    def client_params
      params.permit(:name, :phone, :email, :code)
    end
  end
end
