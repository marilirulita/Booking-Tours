class ApplicationController < ActionController::API
  include JsonWebToken
  before_action :authenticate_request

  protected

  def authenticate_request
    header = request.headers['Authorization']
    if header.present?
      begin
        header = header.split.last if header
        decoded = jwt_decode(header)
        @current_user = User.find(decoded[:user_id])
      rescue ActiveRecord::RecordNotFound => e
        render json: { errors: e.message }, status: :unauthorized
      end

    end
    render json: { errors: 'Authorization header not present' }.to_json, status: :bad_request unless header
  end

  def current_user
    header = request.headers['Authorization']
    header = header.split.last if header
    decoded = jwt_decode(header)
    @current_user = User.find(decoded[:user_id])
  end
end
