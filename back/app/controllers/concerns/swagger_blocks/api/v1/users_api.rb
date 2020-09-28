module SwaggerBlocks::Api::V1::UsersApi
  extend ActiveSupport::Concern
  include Swagger::Blocks

  included do
    include SwaggerBlocks::ErrorSchema
    include SwaggerBlocks::Api::V1::Parameters

    swagger_path "/api/v1/users/{id}" do
      operation :get do
        key :description, "Returns the specified user"
        key :operationId, :get

        parameter name: :id do
          key :in, :path
          key :description, "User ID"
          key :required, true
          key :type, :integer
          key :format, :int64
        end

        response 200 do
          key :description, "User"
          schema do
            key :required, [:id, :name]
            property :id do
              key :type, :integer
              key :format, :int64
            end
            property :name do
              key :type, :string
            end
          end
        end

        extend SwaggerBlocks::Api::V1::ErrorResponses::NotFoundError
      end
    end
  end
end
