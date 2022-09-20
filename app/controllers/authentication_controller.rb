class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  def login
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token = jwt_encode(user_id: @user.id)
      render json: { token:, user: { name: @user.name, user_id: @user.id } }, status: :ok
    else
      render json: { error: 'Wrong email or password' }, status: :unauthorized
    end
  end
end
