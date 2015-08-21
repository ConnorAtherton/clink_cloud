module ClinkCloud
  class GroupMapping
    include Kartograph::DSL

    kartograph do
      mapping Group

      property :id, scopes: [:read]
      property :name, scopes: [:read]
      property :description, scopes: [:read]
      property :locationId, scopes: [:read]
      property :type, scopes: [:read]
      property :status, scopes: [:read]
      property :serversCount, scopes: [:read]
      property :groups, scopes: [:read]
      property :changeInfo, scopes: [:read]
      property :customFields, scopes: [:read]
      property :links, scopes: [:read]
    end
  end
end
