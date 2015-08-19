module ClinkCloud
  class NetworkMapping
    include Kartograph::DSL

    kartograph do
      mapping Network

      property :id, scopes: [:read]
      property :name, scopes: [:read]
      property :cidr, scopes: [:read]
      property :description, scopes: [:read]
      property :gateway, scopes: [:read]
      property :netmask, scopes: [:read]
      property :type, scopes: [:read]
      property :vlan, scopes: [:read]
      property :links, scopes: [:read]
    end
  end
end
