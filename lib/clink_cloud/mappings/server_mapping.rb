module ClinkCloud
  class ServerMapping
    include Kartograph::DSL

    kartograph do
      mapping Server

      property :id, scopes: [:read, :create]
      property :name, scopes: [:read, :create]
      property :description, scopes: [:read, :create]
      property :groupId, scopes: [:read, :create]
      property :isTemplate, scopes: [:read, :create]
      property :locationId, scopes: [:read, :create]
      property :osType, scopes: [:read, :create]
      property :status, scopes: [:read, :create]
      property :details, scopes: [:read, :create]
      property :type, scopes: [:read, :create]
      property :storageType, scopes: [:read, :create]
      property :changeInfo, scopes: [:read, :create]
      property :links, scopes: [:read, :create]
    end
  end
end
