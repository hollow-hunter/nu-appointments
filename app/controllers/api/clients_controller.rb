module Api
  class ClientsController < ActionController::API
    before_action :set_client, only: %i[show update]
    def index
      clients = Client.all
      render json: clients, status: :ok
    end

    def create
      client = Client.new client_params
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

    private

    def set_client
      @client = Client.find(params[:id])
    end

    def client_params
      params.permit(:name, :phone, :email, :code)
    end
  end
end
