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
          DataCenterMapping.extract_collection(response.body.to_json, :read)
        end
      end

      action :find do
        verb :get
        path { "/v2/datacenters/#{account_alias}/:id?groupLinks=true" }
        handler(200) do |response|
          DataCenterMapping.extract_single(response.body.to_json, :read)
        end
      end

      action :get_deployment_capabilities do
        verb :get
        path { "/v2/datacenters/#{account_alias}/:id/deploymentCapabilities" }
        handler(200) do |response|
          # just a simple string
          response.body
        end
      end

      action :get_bare_deployment_capabilities do
        verb :get
        path { "/v2/datacenters/#{account_alias}/:id/bareDeploymentCapabilities" }
        handler(200) do |response|
          # just a simple string
          response.body
        end
      end
    end
  end
end
