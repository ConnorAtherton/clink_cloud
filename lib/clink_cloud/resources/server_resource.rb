module ClinkCloud
  class ServerResource < BaseResource
    resources do
      default_handler do |response|
        fail "Unexpected response status #{response.status}... #{response.body}"
      end

      action :all do
        verb :get
        path { "/v2/servers/#{account_alias}" }
        handler(200) do |response|
          ServerMapping.extract_collection(response.body, :read)
        end
      end

      action :find do
        verb :get
        path { "/v2/servers/#{account_alias}/:id" }
        handler(200) do |response|
          ServerMapping.extract_single(response.body, :read)
        end
      end

      action :delete do
        verb :delete
        path { "/v2/servers/#{account_alias}/:id" }
        handler(202) do |response|
          ServerMapping.extract_single(response.body, :read)
        end
      end

      action :create do
        verb :post
        path { "/v2/servers/#{account_alias}" }
        body { |object| ServerMapping.representation_for(:create, object) }
        handler(202) do |response|
          ServerMapping.extract_single(response.body, :read)
        end
      end

      action :clone do
        verb :post
        path { "/v2/servers/#{account_alias}" }
        body { |object| ServerMapping.representation_for(:clone, object) }
        handler(202) do |response|
          ServerMapping.extract_single(response.body, :read)
        end
      end

      action :update, 'PATCH /v1/servers' do
        # Object with no transforms
        body { |object| object }
        handler(202) do |response|
          ServerMapping.extract_single(response.body, :read)
        end
      end
    end
  end
end
