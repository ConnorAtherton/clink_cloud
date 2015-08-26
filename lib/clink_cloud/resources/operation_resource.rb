module ClinkCloud
  class OperationResource < BaseResource
    resources do
      default_handler do |response|
        fail "Unexpected response status #{response.status}... #{response.body}"
      end

      # TODO: underscore these
      %i(pause powerOff powerOn reboot shutDown).each do |action|
        action action do
          verb :post
          path { "/v2/operations/#{account_alias}/servers/#{action}" }
          # pass in an array of ids or single id string
          body { |object| object.is_a?(Array) ? object : [object] }
          handler(200) do |response|
            binding.pry
            OperationMapping.extract_collection(response.body.to_json, :read)
          end
        end
      end
    end
  end
end
