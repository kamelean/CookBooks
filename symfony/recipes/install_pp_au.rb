require 'aws-sdk'

s3 = AWS::S3.new

#Globals
vhost_bucket = "vhosts/"
vhost_path = "/etc/apache2/sites-enabled/"

node[:deploy].each do |application, deploy|
  # Set bucket and object name
  obj = s3.buckets['ops-works-config'].objects['au-pp.json']

# Read content to variable
  file_content = obj.read

# Log output (optional)
# Chef::Log.info(file_content)

  sites = JSON.parse(file_content)
  sites['site'].each do |current|

    #Get vhost and write to file
    tmp_vhost_bucket = vhost_bucket + current[1]['vhost']
    obj_vhost = s3.buckets['ops-works-config'].objects[tmp_vhost_bucket]
    file_content = obj_vhost.read
    tmp_vhost_path = vhost_path + current[1]['vhost']
    file tmp_vhost_path do
      content file_content
      action :create
    end

    #Get web app file
    obj_app = s3.buckets['ops-works-config'].objects["pp_apps/" + current[1]['web_app']]
    file_content_app = obj_app.read
    file "#{deploy[:deploy_to]}/current/web/" + current[1]['web_app'] do
      content file_content_app
      action :create
    end

    #Copy and update parameter file
    file_names = ['#{deploy[:deploy_to]}/current/' + current[1]['app_folder'] + '/config/parameters_pp.dist.yml']

    file_names.each do |file_name|
      text = File.read(file_name)
      new_contents = text.gsub("YOUR_USER", current[1]['user'])
      new_contents = new_contents.gsub("YOUR_PASSWORD", current[1]['pass'])

      # To merely print the contents of the file, use:
      #puts new_contents

      # To write changes to the file, use:
      File.open('#{deploy[:deploy_to]}/current/' + current[1]['app_folder'] + '/config/parameters_pp.yml', "w") {|file| file.puts new_contents }

      #log "I have #{current[1]['user']}" do
      #  level :info
      #end
    end
  end
end
