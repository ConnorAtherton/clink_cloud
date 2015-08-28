module ClinkCloud
  class GroupResource < BaseResource
    resources do
      default_handler do |response|
        fail "Unexpected response status #{response.status}... #{response.body}"
      end

      action :find do
        verb :get
        path { "/v2/groups/#{account_alias}/:id" }
        handler(200) do |response|
          GroupMapping.extract_single(response.body.to_json, :read)
        end
      end

      action :defaults do
        verb :get
        path { "/v2/groups/#{account_alias}/:id/defaults" }
        handler(200) do |response|
          # for now
          response.body
          # GroupMapping.extract_single(response.body.to_json, :read)
        end
      end

      action :destroy do
        verb :delete
        path { "/v2/groups/#{account_alias}/:id" }
        handler(202) do |response|
          response.body.delete('id')
        end
      end

      action :create do
        verb :post
        path { "/v2/groups/#{account_alias}" }
        body { |object| GroupMapping.representation_for(:create, object) }
        handler(201) do |response|
          GroupMapping.extract_single(response.body.to_json, :read)
        end
      end
    end
  end
end
