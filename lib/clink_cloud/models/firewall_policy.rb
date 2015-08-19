module ClinkCloud
  class FirewallPolicy < Base
    attribute :id
    attribute :status
    attribute :enabled
    attribute :source
    attribute :destination
    attribute :destinationAccount
    attribute :ports
    attribute :links
  end
end
