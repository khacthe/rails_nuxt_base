class ApplicationController < ActionController::API
  include ActionController::Serialization

  include BaseApi

  serialization_scope nil

  def authenticate_user!
    handle_error! :unauthenticated unless current_user || current_user&.activated
  end

  private
  def token_access_header
    auth_header = request.headers[Settings.token_access_header]
    return nil unless auth_header

    auth_header.scan(/^#{Settings.token_access_prefix} (.+)$/i).dig 0, 0
  end

  def current_user
    @current_user ||= User.find payload[0]["user_id"] if payload.present?
  end

  def payload
    @payload ||= JsonWebToken.decode token_access_header if token_access_header
  end
end
