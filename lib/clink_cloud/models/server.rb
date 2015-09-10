module ClinkCloud
  class Server < Base
    attribute :id
    attribute :name
    attribute :description
    attribute :groupId
    attribute :isTemplate
    attribute :locationId
    attribute :osType
    attribute :status
    attribute :details
    attribute :type
    attribute :changeInfo

    # only on create
    attribute :memoryGB
    attribute :cpu
    attribute :sourceServerId
    attribute :ttl
    attribute :password
    attribute :storageType
  end
end
