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
    attribute :storageType
    attribute :changeInfo

    # only on create
    attribute :memoryGB
    attribute :cpu
    attribute :sourceServerId
  end
end
