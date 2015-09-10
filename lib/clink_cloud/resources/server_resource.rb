module ClinkCloud
  class ServerResource < BaseResource
    resources do
      default_handler do |response|
        fail "Unexpected response status #{response.status}... #{response.body}"
      end

      action :find do
        verb :get
        path { "/v2/servers/#{account_alias}/:id" }
        handler(200) do |response|
          ServerMapping.extract_single(response.body.to_json, :read)
        end
      end

      # Requires package ID, currently only available by browsing control and browsing
      # for the package itself. The UUID parameter is the package ID we need
      action :execute_package do
        verb :post
        path { "/v2/operations/#{account_alias}/servers/executePackage" }
        body { |object| object.to_json }
        handler(200) do |response|
          Operation.extract_collection(response.body.to_json, :read)
        end
      end

      action :destroy do
        verb :delete
        path { "/v2/servers/#{account_alias}/:id" }
        handler(202) do |response|
          OperationMapping.extract_single(response.body.to_json, :read)
        end
      end

      action :create do
        verb :post
        path { "/v2/servers/#{account_alias}" }
        body { |object| binding.pry if ENV['CLINK_DEBUG']; ServerMapping.representation_for(:create, object) }

        handler(500) do |response|
          raise ClinkCloud::Errors::ServerError.new(response.body)
        end

        handler(202) do |response|
          # easier to just use a hash
          res = { 'id' => response.body['server'] }
          map = { 'status' => 'status_id' }

          response.body['links'].each do |link|
            key = map[link['rel']]
            next if key.nil?
            res[key] = link['id']
          end

          res
        end
      end

      # action :clone do
      #   verb :post
      #   path { "/v2/servers/#{account_alias}" }
      #   body { |object| ServerMapping.representation_for(:clone, object) }
      #   handler(202) do |response|
      #     ServerMapping.extract_single(response.body, :read)
      #   end
      # end

      action :update, 'PATCH /v1/servers' do
        # Object with no transforms
        body { |object| object }
        handler(202) do |response|
          ServerMapping.extract_single(response.body.to_json, :read)
        end
      end
    end
  end
end
