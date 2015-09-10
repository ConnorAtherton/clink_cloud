module ClinkCloud
  class IpAddressMapping
    include Kartograph::DSL

    kartograph do
      mapping IpAddress

      property :internalIPAddress, scopes: [:read, :create, :update]
      property :ports, scopes: [:read, :create, :update]
      property :sourceRestrictions, scopes: [:read, :create, :update]
      property :publicIP, scope: [:read]
    end
  end
end
