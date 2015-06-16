require 'aws-sdk'

s3 = AWS::S3.new

# Set bucket and object name
obj = s3.buckets['ops-works-config'].objects['au-pp.json']

# Read content to variable
file_content = obj.read

# Log output (optional)
# Chef::Log.info(file_content)

sites = JSON.parse(file_content)
sites['site'].each do |current|
  obj_vhost = s3.buckets['ops-works-config'].objects["vhosts/" + current[1]['vhost']]
  file_content = obj_vhost.read

  file '/etc/apache2/sites-enabled/' + current[1]['vhost'] do
    content file_content
    action :create
  end

  #log "I have #{current[1]['user']}" do
  #  level :info
  #end
end