module Api::V1
  class ApiDocsController < ApplicationController
    include Swagger::Blocks

    swagger_root do
      key :swagger, "2.0"
      info do
        key :version, "1.0"
        key :title, I18n.t("swagger_project.title")
        key :description, I18n.t("swagger_project.description")
      end
      extend SwaggerBlocks::Api::V1::Parameters
    end

    SWAGGERED_CLASSES = [
      Api::V1::UsersController,
      User,
      self
    ].freeze

    def index
      render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
    end

    private
    def process_user_token_and_response user
      authen_token = JsonWebToken.encode generate_attr(user)

      json_response(:created, token: authen_token, exp: Time.zone.at(JsonWebToken.meta[:exp]),
                    user: UserSerializer.new(user))
    end

    def collection_serializer data, model, scope = {}
      ActiveModelSerializers::SerializableResource.new(data, adapter: :attributes,
                                                        scope: scope, each_serializer: model)
    end

    def generate_attr user
      {user_id: user.id, email: user.email}
    end
  end
end
