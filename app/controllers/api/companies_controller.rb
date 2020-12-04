module Api
  class CompaniesController < ActionController::API
    def create
      c = Company.new(company_params)
      if c.save
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
