module ClinkCloud
  class StatusResource < BaseResource
    resources do
      default_handler do |response|
        fail "Unexpected response status #{response.status}... #{response.body}"
      end

      action :find do
        verb :get
        path { "/v2/operations/#{account_alias}/status/:id" }
        handler(200) do |response|
          # just a simple string
          response.body
        end
      end
    end
  end
end
