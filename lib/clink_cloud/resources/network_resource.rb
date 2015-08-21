module ClinkCloud
  class NetworkResource < BaseResource
    resources do
      default_handler do |response|
        fail "Unexpected response status #{response.status}... #{response.body}"
      end

      action :all do
        verb :get
        path { "/v2-experimental/networks/#{account_alias}/:data_center" }
        handler(200) do |response|
          NetworkMapping.extract_collection(response.body.to_json, :read)
        end
      end

      action :find do
        verb :get
        path { "/v2-experimental/networks/#{account_alias}/:data_center/:id" }
        handler(200) do |response|
          NetworkMapping.extract_collection(response.body.to_json, :read)
        end
      end

      action :ip_addresses do
        verb :get
        path { "/v2-experimental/networks/#{account_alias}/:data_center/:id/ipAddresses" }
        handler(200) do |response|
          NetworkMapping.extract_collection(response.body.to_json, :read)
        end
      end

      action :claim do
        verb :get
        path { "/v2-experimental/networks/#{account_alias}/:data_center/claim" }
        handler(200) do |response|
          NetworkMapping.extract_single(response.body.to_json, :read)
        end
      end
    end
  end
end
