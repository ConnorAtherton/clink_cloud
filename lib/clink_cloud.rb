require "clink_cloud/version"
require "virtus"
require "resource_kit"

module ClinkCloud
  # client
  autoload :Client, 'clink_cloud/client'

  # models
  autoload :Base, 'clink_cloud/models/base'
  autoload :Server, 'clink_cloud/models/server'

  # mappings
  autoload :ServerMapping, 'clink_cloud/mappings/server_mapping'

  # resources
  autoload :BaseResource, 'clink_cloud/resources/base_resource'
  autoload :ServerResource, 'clink_cloud/resources/server_resource'
end
