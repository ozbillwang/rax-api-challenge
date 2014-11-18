#!/usr/bin/env ruby

require 'fog'

rackspace_username = abc
rackspace_api_key = xyz

# must specify a name for the cloned server
if ARGV.length != 2
  puts "need source and dest directories"
  exit
end

srcdir = ARGV.shift
destdir = ARGV.shift

# insure source dir exists
if not File.directory?(srcdir)
  puts "Source directory must exist"
  exit
end

# create Cloud Files storage service
service = Fog::Storage.new({
  :provider             => 'rackspace',
  :rackspace_username   => rackspace_username,
  :rackspace_api_key    => rackspace_api_key,
  :rackspace_region => options.dc #Use specified region
})

container = service.directories.create(:key => destdir)

# upload all files in directory to container
puts "Uploading all files from directory #{srcdir} to container #{container}"
Dir.foreach(srcdir) do |file|
  next if file == '.' or file == '..' or File.directory?(file)
  puts "Uploading #{file}"
  container.files.create(:key => file, :body => File.open(file))
end
