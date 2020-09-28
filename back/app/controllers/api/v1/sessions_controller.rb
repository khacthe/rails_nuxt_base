module Api::V1
  class SessionsController < ApiDocsController
    include SwaggerBlocks::Api::V1::Sessions

    def sign_in
      user = User.find_by email: _params[:email]
      raise ApiError::UserNotFound unless user

      raise ApiError::UserUnauthenticated unless user&.activated?

      raise ApiError::LoginWrong unless user&.authenticate(user_params[:password])

      process_user_token_and_response user
    end

    def sign_up
      ActiveRecord::Base.transaction do
        user = User.create! user_params.merge(password_normal: params[:password])
        SignUpWorker.perform_async user.id
      end
    end

    def verify_user
      user = User.find_by email: params[:email]
      raise ApiError::UserNotFound unless user

      raise ApiError::AuthTokenNotFound if params[:auth_token].blank? || token_not_match(params[:auth_token], user)

      raise ApiError::UserAuthenticated if user.activated

      user.update! activated: true, activated_at: Time.zone.now
      process_user_token_and_response user
    end

    def forgot_password
      user = User.find_by email: user_params[:email]
      raise ApiError::UserNotFound unless user

      user.update! reset_password_sent_at: Time.zone.now
      ResetPasswordWorker.perform_async user.id
    end

    def password_reset
      user = User.find_by email: params[:email]
      raise ApiError::UserNotFound unless user

      if params[:auth_token].blank? || user&.reset_password_sent_at.blank? ||
          token_not_match(params[:auth_token], user)
        raise ApiError::AuthTokenNotFound
      end

      user.update! password_reset_params.merge(password_normal: params[:password], reset_password_sent_at: nil)
      process_user_token_and_response user
    end

    def sign_out
      auth_token = JWT.encode({exp: Time.zone.now.to_i}, Rails.application.secrets.secret_key_base)
      json_response(:ok, token: auth_token)
    end

    private
    def user_params
      params.permit :email, :password, :password_confirmation, :agreed_rule
    end

    def password_reset_params
      params.permit :password, :password_confirmation
    end

    def token_not_match auth_token, user
      decode = JsonWebToken.decode(auth_token).first
      true unless decode.try(:[], "user_id") == user.id && decode.try(:[], "email") == user.email
    rescue StandardError => _e
      true
    end
  end
end
