require 'clink_cloud/version'
require 'kartograph'

#
# Autload each module/class only
# when they are accessed. The resources are
# the most commonly used entity and are
# exposed through method_missing in the client
# class.
#
module ClinkCloud
  # client
  autoload :Client, 'clink_cloud/client'

  # models
  autoload :Base, 'clink_cloud/models/base'
  autoload :Server, 'clink_cloud/models/server'
  autoload :DataCenter, 'clink_cloud/models/data_center'
  autoload :Group, 'clink_cloud/models/group'
  autoload :IpAddress, 'clink_cloud/models/ip_address'
  autoload :Network, 'clink_cloud/models/network'
  autoload :Operation, 'clink_cloud/models/operation'
  autoload :Status, 'clink_cloud/models/status'

  # mappings
  autoload :ServerMapping, 'clink_cloud/mappings/server_mapping'
  autoload :NetworkMapping, 'clink_cloud/mappings/network_mapping'
  autoload :GroupMapping, 'clink_cloud/mappings/group_mapping'
  autoload :DataCenterMapping, 'clink_cloud/mappings/data_center_mapping'
  autoload :OperationMapping, 'clink_cloud/mappings/operation_mapping'
  autoload :FirewallPolicyMapping, 'clink_cloud/mappings/firewall_policy_mapping'
  autoload :IpAddressMapping, 'clink_cloud/mappings/ip_address_mapping'

  # resources
  autoload :BaseResource, 'clink_cloud/resources/base_resource'
  autoload :ServerResource, 'clink_cloud/resources/server_resource'
  autoload :DataCenterResource, 'clink_cloud/resources/data_center_resource'
  autoload :FirewallPolicyResource, 'clink_cloud/resources/firewall_policy_resource'
  autoload :IpAddressResource, 'clink_cloud/resources/ip_address_resource'
  autoload :NetworkResource, 'clink_cloud/resources/network_resource'
  autoload :GroupResource, 'clink_cloud/resources/group_resource'
  autoload :OperationResource, 'clink_cloud/resources/operation_resource'
  autoload :StatusResource, 'clink_cloud/resources/status_resource'

  module Errors
    class Base < RuntimeError; end
    class ServerError < Base; end
    class RequestError < Base; end
  end
end
