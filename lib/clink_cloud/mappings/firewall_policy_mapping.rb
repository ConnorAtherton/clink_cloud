module ClinkCloud
  class FirewallPolicyMapping
    include Kartograph::DSL

    kartograph do
      mapping FirewallPolicy

      property :id, scopes: [:read]
      property :status, scopes: [:read]
      property :enabled, scopes: [:read]
      property :source, scopes: [:read]
      property :destination, scopes: [:read]
      property :destinationAccount, scopes: [:read]
      property :ports, scopes: [:read]
      property :links, scopes: [:read]
    end
  end
end
