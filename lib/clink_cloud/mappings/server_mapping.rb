module ClinkCloud
  class ServerMapping
    include Kartograph::DSL

    kartograph do
      mapping Server

      property :id, scopes: [:read]
      property :name, scopes: [:read, :create]
      property :description, scopes: [:read, :create]
      property :groupId, scopes: [:read, :create]
      property :isTemplate, scopes: [:read]
      property :locationId, scopes: [:read]
      property :osType, scopes: [:read]
      property :status, scopes: [:read]
      property :details, scopes: [:read]
      property :type, scopes: [:read, :create]
      property :storageType, scopes: [:read]
      property :changeInfo, scopes: [:read]
      property :links, scopes: [:read]
      property :memoryGB, scopes: [:create]
      property :cpu, scopes: [:create]
      property :sourceServerId, scopes: [:create]
    end
  end
end
