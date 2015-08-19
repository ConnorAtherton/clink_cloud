require 'bundler/setup'
require 'clink_cloud'
require 'securerandom'
require 'pry'

# create a client
client = ClinkCloud::Client.new(username: ARGV.shift, password: ARGV.shift)

"List all servers running"
servers = client.servers.all
binding.pry
