module Api::V1
  class UsersController < ApiDocsController
    include SwaggerBlocks::Api::V1::UsersApi

    def show
      @user = User.find_by id: params[:id]
      json_response(:ok, email: @user.email, name: @user.name)
    end
  end
end
