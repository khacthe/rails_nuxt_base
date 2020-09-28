module SwaggerBlocks::Api::V1::ErrorResponses
  module NotFoundError
    def self.extended base
      base.response 404 do
        key :description, "Resource not found"
        schema do
          key :"$ref", :Errors
        end
      end
    end
  end
end
