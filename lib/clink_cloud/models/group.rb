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

    def servers
      @servers ||= links.select { |l| true if l['rel'] == 'server' }
                        .map { |s| s['id'] }
    rescue
      # This happends when accessing group_id on an object
      # sculpted from within a collection. Need to use .find to
      # get more links
      nil
    end
  end
end
