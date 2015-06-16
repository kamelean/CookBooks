require 'aws-sdk'

s3 = AWS::S3.new

# Set bucket and object name
obj = s3.buckets['ops-works-config'].objects['fruits.json']

# Read content to variable
file_content = obj.read

# Log output (optional)
Chef::Log.info(file_content)

fruits = JSON.parse(file_content)

fruits['fruit'].each do |fruit|
  log "I have #{fruit}" do
    level :info
  end
end