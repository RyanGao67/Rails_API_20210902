class RegistrationsController < ApplicationController
  def create
    user = User.create!(
      email: params['user']['email'],
      password: params['user']['password'],
      password_confirmation: params['user']['password_confirmation']
    )

    if user
      cookies[:user_id] = {
        value: user.id,
        secure: true,
        same_site: :none,
        expires: 1.hour
      }
      render json: {
        status: :created,
        user: user
      }
    else
      render json: {status: 500}
    end
  end
end