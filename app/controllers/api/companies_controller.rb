module Api
  class CompaniesController < ApiController
    before_action only: %i[create] do
      if doorkeeper_token
        doorkeeper_authorize! :write
      else
        authenticate_user!
      end
    end

    def create
      c = Company.new(company_params)
      if current_user.company_id.nil? && c.save
        current_user.update company_id: c.id
        render json: c, status: :created
      else
        render json: c.errors, status: :bad_request
      end
    end

    private

    def company_params
      params.permit(:name)
    end
  end
end
