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
puts "data center root group #{dc_group.id}"
server_name = "test06"
puts "server name #{server_name}"

# do we already have a launchpad group?
g_name = 'bitnami-launchpad-group'
already_group = nil
lp_group_id = nil
dc_group.groups.each do |g|
  puts g['name'], g['id']

  if g['name'] == g_name
    already_group = true
    lp_group_id = g['id']
    break
  end
end

#
# Create a new group to use for launching vms in
#
unless already_group
  puts "no group called #{g_name}"
  group = ClinkCloud::Group.new(
    name: g_name,
    description: 'A brief description',
    # parentGroupId: dc.group_id
    parentGroupId: "74d2834bc65de411877f005056882d41"
  )

  # group = client.groups.create(group)
  # puts "created a group with id #{group.id}"
else
  # delete the launchpad group
  puts 'deleting the launchpad group'
  client.groups.destroy(id: lp_group_id)
end

#
# Server operations
#
# LET'S CREATE A SERVER!!
server = {
  name: server_name,
  # launch in the first dc in the list
  groupId: (group && group.id) || launch_group_id,
  sourceServerId: 'UBUNTU-14-64-TEMPLATE',
  storageType: 'premium',
  # what is the correct format for this
  # ttl: 'Sat, 29 Aug 2015 03:22:37 UTC +00:00',
  packages: [
    {
      # Install bitnami wordpress
      # TODO: id
      # packageId: '3dccadc2-9b51-421e-92a4-ee86abd41b35',
      # TODO: uuid
      packageId: '3eba43d7-de2f-4713-a647-b26fba6fea31',
      # NOTE:  The password is not sufficiently strong. (ERROR)
      parameters: {
        'T3.bitnami.base_password' => '1nZoODUD!?'
      }
    }
  ],
  ttl: "2015-09-15T02:11:37Z",
  cpu: '1',
  memoryGB: '1',
  type: 'standard',
  # the call fails if the password is not strong enough
  password: '1nZoODUD'
}
server = ClinkCloud::Server.new(server)

# server_obj = {
#   name: name,
#   groupId: group_id,
#   sourceServerId: temporary_image_id,
#   cpu: num_cpus.to_s,
#   storageType: disk_type.to_s,
#   memoryGB: memory.to_s,
#   type: 'standard'
# }

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

binding.pry

# fetch the first server we have in the group
launch_group = client.groups.find(id: launch_group_id)
sobjs = launch_group.servers(client)

#
# Fetch correct server object
server_id = sobjs.first.id

server_id_ip = sobjs.first.id
ip_status = nil

# Try adding a public ip if we have a server
# NOTE: port can be "tcp", "udp", or "icmp".
# if server_id_ip
#   ip_status = client.ip_addresses.create(
#     server_id: sobjs.first.id,
#     ports: [
#       {
#         'protocol' => 'TCP',
#         'port' => 80
#       }
#     ]
#   )
# end

###
#
# Clean up code
#
###

# remove all servers
launch_group = client.groups.find(id: launch_group_id)
sobjs = launch_group.servers(client)
sid = launch_group.find_server_id(name: server_name, dc_id: dc.id, account_alias: client.alias)

# sobjs.each do |obj|
#   id = obj.id

#   if obj.status == 'running'
#     puts "shutting down #{id} instead of destroying"
#     client.operations.powerOff(id: id)
#     next
#   end

#   unless obj.status == 'queuedForDelete'
#     puts "destroying server #{id}"
#     client.servers.destroy(id: id)
#     next
#   end

#   puts "server #{id} is already queued for deletion"
# end

# remove all groups
# dc_group.groups.each do |g|
#   next unless g['name'] == g_name
#   puts "deleting group #{g['id']}"
#   client.groups.destroy(id: g['id'])
# end
