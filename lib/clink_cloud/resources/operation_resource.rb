module ClinkCloud
  class OperationResource < BaseResource
    resources do
      default_handler do |response|
        fail "Unexpected response status #{response.status}... #{response.body}"
      end

      %i(:pause :power_off :power_on :reboot :shutDown).each do |action|
        action action do
          verb :post
          path { "/v2/operations/#{account_alias}/servers/#{action}" }
          # pass in an array of ids or single id string
          body { |object| object.is_a?(Array) ? object : [object] }
          handler(200) do |response|
            OperationMapping.extract_collection(response.body, :read)
          end
        end
      end
    end
  end
end
