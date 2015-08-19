module ClinkCloud
  class ServerMapping
    include Kartograph::DSL

    kartograph do
      mapping Server

      property :id, scopes: [:read]
      property :name, scopes: [:read]
      property :description, scopes: [:read]
      property :groupId, scopes: [:read]
      property :isTemplate, scopes: [:read]
      property :locationId, scopes: [:read]
      property :osType, scopes: [:read]
      property :status, scopes: [:read]
      property :details, scopes: [:read]
      property :type, scopes: [:read]
      property :storageType, scopes: [:read]
      property :changeInfo, scopes: [:read]
      property :links, scopes: [:read]
    end
  end
end
