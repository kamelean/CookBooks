require 'aws-sdk'

s3 = AWS::S3.new

# Set bucket and object name
obj = s3.buckets['ops-works-config'].objects['au-pp.json']

# Read content to variable
file_content = obj.read

# Log output (optional)
Chef::Log.info(file_content)

sites = JSON.parse(file_content)

sites['site'].each do |site|
  log "I have #{site}" do
    level :info
  end
end