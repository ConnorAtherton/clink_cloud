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
# dcs.each { |dc| puts dc.name, dc.id }

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

#
# Let's always use canada for testing
#
dc = client.data_centers.find(id: 'ca1')
defs = client.groups.defaults(id: dc.group_id)
dc_group = client.groups.find(id: dc.group_id)
puts "root group #{dc_group.id}"
template_id = client.data_centers.get_deployment_capabilities(id: dc.id)['templates'].first['name']
# TODO: need a better metric for what to do here
launch_group_id = dc_group.groups.find { |gr| gr['name'] == "Default Group" }['id']
puts "launch group #{launch_group_id}"
server_name = "test#{SecureRandom.hex(1)}"
puts "server name #{server_name}"

#
# Server operations
#
# LET'S CREATE A SERVER!!
server = ClinkCloud::Server.new(
  name: server_name,
  # launch in the first dc in the list
  groupId: launch_group_id,
  sourceServerId: template_id,
  cpu: '1',
  memoryGB: '1',
  type: 'standard'
  # only for bare metal servers
  # configurationId: ''
  # osType: ''
)


def wait_for(client, status_id)
  tries = 0

  loop do
    status = client.statuses.find(id: status_id)
    puts status
    sleep 5 && tries += 1
    break if status['status'] == 'succeeded' || tries > 48
  end

  puts "finished waiting for #{status_id}"
end

# actually creating
server = client.servers.create(server)
wait_for(client, server['status_id'])

# Clean up code
launch_group = client.groups.find(id: launch_group_id)
sobjs = launch_group.servers(client)
sid = launch_group.find_server_id(name: server_name, dc_id: dc.id, account_alias: client.alias)
binding.pry
launch_group.servers.each { |id| client.servers.delete(id: id) }
