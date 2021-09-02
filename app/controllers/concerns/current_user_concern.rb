module CurrentUserConcern
  extend ActiveSupport::Concern
  included do
    before_action :set_current_user
  end
  def set_current_user
    if cookies[:user_id]
      byebug
      @current_user = User.find(cookies[:user_id])
    end
  end
end