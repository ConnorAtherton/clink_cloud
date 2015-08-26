module ClinkCloud
  class GroupMapping
    include Kartograph::DSL

    kartograph do
      mapping Group

      property :id, scopes: [:read]
      property :name, scopes: [:read, :create]
      property :description, scopes: [:read, :create]
      property :parentGroupId, scopes: [:read, :create]
      property :locationId, scopes: [:read]
      property :type, scopes: [:read]
      property :status, scopes: [:read]
      property :serversCount, scopes: [:read]
      property :groups, scopes: [:read]
      property :changeInfo, scopes: [:read]
      property :customFields, scopes: [:read]
      property :links, scopes: [:read]
      # property :id, scopes: [:read] do |object|
      #   # The result of the block becomes the prop value
      # end
    end
  end
end
