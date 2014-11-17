#!/usr/bin/env ruby

require 'fog'

srcname = web1

# must specify a name for the cloned server
if ARGV.length != 1
  puts "Destination server name is required"
  p optparse
  exit
end
destname = ARGV.shift

# set the conneciton
service = Fog::Compute.new({
  :provider             => 'rackspace',
  :rackspace_username   => rackspace_username,
  :rackspace_api_key    => rackspace_api_key,
  :version              => :v2,  
  :rackspace_region     => :ord
})

toclone = service.servers.find {|s| s.name == srcname }
if not toclone
  puts "Could not locate server named #{options.srcname}"
  exit
end

# create an image of source server
imagename = srcname + "challenge2"
print "Building image of #{toclone.name}"
image = toclone.create_image(imagename)

sleep 300

# create server from built image, with same flavor as source server
print "Building clone #{destname} from image of #{toclone.name}"
server = service.servers.create(:name => destname,
                                :flavor_id => toclone.flavor.id,
                                :image_id => image.id)

sleep 300

# output clone server information
puts "#{server.name}: IPv4: #{server.ipv4_address} IPv6: #{server.ipv6_address} username: #{server.username} password: #{server.password}"
