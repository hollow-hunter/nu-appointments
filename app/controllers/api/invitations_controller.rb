module Api
  class InvitationsController < ActionController::API
    def create
      i = Invitation.new(invitation_params)
      i.company_id = current_user.company_id
      if i.save
        InvitationMailer.invitation_created(i.email, i.code, i.company.name).deliver_later
        render json: { id: i.id }, status: :created
      else
        render json: i.errors, status: :bad_request
      end
    end

    private

    def invitation_params
      params.permit(:email)
    end
  end
end
