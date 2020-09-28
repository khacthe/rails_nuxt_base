module SwaggerBlocks::ErrorSchema
  extend ActiveSupport::Concern
  include Swagger::Blocks

  included do
    swagger_schema :Errors do
      key :required, [:errors]
      property :errors do
        key :type, :array
        items do
          key :type, :string
        end
      end
    end
  end
end
