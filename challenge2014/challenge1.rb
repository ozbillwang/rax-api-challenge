#!/usr/bin/env ruby
# I have no environment to access rackspace clound system, have to refer the exist code. 
# refer URL - https://raw.githubusercontent.com/tofupup/rax-ruby-cloud/master/challenge1.rb

require 'fog'

# command line options
flavor = "2"
image = "5cebb13a-f783-4f8c-8058-c4182c724ccd"
namebase = "web"

# create Next Generation Cloud Server service
instance = Fog::Compute.new({
  :provider             => 'rackspace',
  :rackspace_username   => rackspace_username,
  :rackspace_api_key    => rackspace_api_key,
  :version              => :v2,  
  :rackspace_region     => :ord
})

# create the servers
servers = []
puts "Creating 3 servers"
for i in 1..3 do
  servers[i] = instance.servers.create({:name => namebase + i.to_s,
                                       :flavor_id => flavor.id,
                                       :image_id => image.id})
end
