module ClinkCloud
  class Group < Base
    attribute :id
    attribute :name
    attribute :description
    attribute :locationId
    attribute :type
    attribute :status
    attribute :serversCount
    attribute :groups
    attribute :changeInfo
    attribute :customFields

    def servers(client = nil)
      links.select { |l| l if l['rel'] == 'server' }
        .map { |s| s['id'] }
        .tap do |servers|
          if client.is_a?(::ClinkCloud::Client)
            # build an array of server objects
            return servers.map { |s| client.servers.find(id: s) }
          end
        end
    rescue
      # This happends when accessing group_id on an object
      # sculpted from within a collection. Need to use .find to
      # get more links
      nil
    end

    # Accepts the name used to create the vm as well
    # as the data center id and account alias and tries to find
    # the server id that matches
    def find_server_id(name:, dc_id:, account_alias:)
      regex = /#{dc_id}#{account_alias}#{name}\d{2}/i
      servers.select { |id| id.match regex }.first
    end
  end
end
