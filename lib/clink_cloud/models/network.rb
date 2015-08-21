module ClinkCloud
  class Network < Base
    attribute :id
    attribute :name
    attribute :cidr
    attribute :description
    attribute :gateway
    attribute :netmask
    attribute :type
    attribute :vlan
  end
end
