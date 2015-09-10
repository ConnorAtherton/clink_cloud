module ClinkCloud
  class ServerActions < BaseResource
    resources do
      default_handler do |response|
        fail "Unexpected response status #{response.status}... #{response.body}"
      end

      action :execute_package do
        verb :post
        path { "/v2/operations/#{account_alias}/servers/executePackage" }
        body { |object| object }
        handler(200) do |response|
          Operation.extract_collection(response.body.to_json, :read)
        end
      end
    end
  end
end
