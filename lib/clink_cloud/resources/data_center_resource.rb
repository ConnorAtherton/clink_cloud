module ClinkCloud
  class DataCenterResource < BaseResource
    resources do
      default_handler do |response|
        fail "Unexpected response status #{response.status}... #{response.body}"
      end

      action :all do
        verb :get
        path { "/v2/datacenters/#{account_alias}" }
        handler(200) do |response|
          DataCenterMapping.extract_collection(response.body, :read)
        end
      end

      action :find do
        verb :get
        path { "/v2/servers/#{account_alias}/:id?groupLinks=true" }
        handler(200) do |response|
          DataCenterMapping.extract_collection(response.body, :read)
        end
      end

      action :delete do
        verb :delete
        path { "/v2/servers/#{account_alias}/:server_id/publicIPAddresses/:id" }
        handler(200) do |response|
          response.body
        end
      end
    end
  end
end
