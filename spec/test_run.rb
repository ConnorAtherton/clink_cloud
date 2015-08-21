require 'bundler/setup'
require 'clink_cloud'
require 'securerandom'
require 'pry'

# create a client
client = ClinkCloud::Client.new(username: ARGV.shift, password: ARGV.shift)

"List all servers running"
# servers = client.servers.all

"List out available data centers"
dcs = client.data_centers.all
dcs.each { |dc| puts dc.name, dc.id }

#
# Data center calls
#
# dc = client.data_centers.find(id: 'de1')
# caps = client.data_centers.get_deployment_capabilities(id: 'de1')
# bcaps = client.data_centers.get_bare_deployment_capabilities(id: 'de1')

#
# Group calls
#
# Need to do an individual fetch to find the group_id
#
# client.groups.find(id: '')
# client.groups.defaults(id: '')
dc = client.data_centers.find(id: dcs.first.id)
g = client.groups.find(id: dc.group_id)
defs = client.groups.defaults(id: dc.group_id)
ssid = client.data_centers.get_deployment_capabilities(id: dc.id)['templates'].first['name']
puts dc.name, g.name
puts ssid

#
# Server operations
#
# LET'S CREATE A SERVER!!
server = ClinkCloud::Server.new(
  name: 'connor-test-server',
  # launch in the first dc in the list
  groupId: dc.group_id,
  sourceServerId: ssid,
  cpu: '1',
  memoryGB: '1',
  type: 'standard'
  # only for bare metal servers
  # configurationId: '',
  # osType: ''
)

# actually create it
server = client.servers.create(server)

#
# Network calls
#

#
# Operation calls
#

#
# Status calls
#
# client.statuses.find(id: '')

binding.pry

#
# Firewall Policy calls
#

#
# IP Address calls
#
