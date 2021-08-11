module AuthorizeAdminConcern
  extend ActiveSupport::Concern

  included do
    before_action :authorize_admin
  end

  def authorize_admin
    authenticate_user!
    if current_user.admin?
      @current_admin = current_user
    else
      flash[:error] = "You're not allowed to perform this action."
      redirect_to root_path, status: :forbidden
    end
  end
end
