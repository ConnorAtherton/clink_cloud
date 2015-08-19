module ClinkCloud
  class NetworkResource < BaseResource
    resources do
      default_handler do |response|
        fail "Unexpected response status #{response.status}... #{response.body}"
      end

      %i(:pause :power_off :power_on :reboot :shutDown).each do |action|
        action action do
          verb :post
          path { "/operations/networks/#{account_alias}/servers/#{action.to_s}" }
          # pass in an array of ids
          body { |object| object }
          handler(200) do |response|
            OperationMapping.extract_collection(response.body, :read)
          end
        end
      end
    end
  end
end
