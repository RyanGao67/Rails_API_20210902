class SessionsController < ApplicationController
  include CurrentUserConcern
  def create
    # response.headers['Set-Cookie'] = 'Secure;SameSite=None'
    user = User
           .find_by(email: params['user']['email'])
           .try(:authenticate, params['user']['password'])
    if user
      cookies[:user_id] = {
        value: user.id,
        secure: true,
        same_site: :none,
        expires: 1.hour
      }
      render json: {
        status: :created,
        logged_in: true,
        user: user
      }
    else
      render json: {
        status: 401
      }
    end

  end

  def logged_in
    # response.headers['Set-Cookie'] = 'Secure;SameSite=None'
    byebug
    if cookies[:user_id]
      byebug
      @current_user = User.find(cookies[:user_id])
    end
    if @current_user
      render json: {
        logger_in: true,
        user: @current_user
      }
    else
      render json: {
        logged_in: false
      }
    end
  end

  def logout
    reset_session
    render json:{status:200, logged_out:true}
  end
end
