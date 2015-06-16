require 'aws-sdk'

s3 = AWS::S3.new

#Globals
vhost_bucket = "vhosts/"
vhost_path = "/etc/apache2/sites-enabled/"

# Set bucket and object name
obj = s3.buckets['ops-works-config'].objects['au-pp.json']

# Read content to variable
file_content = obj.read

# Log output (optional)
# Chef::Log.info(file_content)

sites = JSON.parse(file_content)
sites['site'].each do |current|
  tmp_vhost_bucket = vhost_bucket + current[1]['vhost']
  obj_vhost = s3.buckets['ops-works-config'].objects[tmp_vhost_bucket]
  file_content = obj_vhost.read

  #Get vhost and write to file
  tmp_vhost_path = vhost_path + current[1]['vhost']
  file tmp_vhost_path do
    content file_content
    action :create
  end

  #log "I have #{current[1]['user']}" do
  #  level :info
  #end
end