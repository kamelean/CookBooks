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
  obj_vhost = s3.buckets['ops-works-config'].objects["vhosts/mintyshop_au_pp.conf"]
  file_content = obj_vhost.read

  #Get vhost and write to file
  file '/etc/apache2/sites-enabled/mintyshop_au_pp.conf' do
    content file_content
    action :create
  end

  #log "I have #{current[1]['user']}" do
  #  level :info
  #end
end