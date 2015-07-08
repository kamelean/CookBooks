require 'aws-sdk'
node[:deploy].each do |application, deploy|

  s3 = AWS::S3.new

  #Globals
  vhost_bucket = "vhosts/"
  vhost_path = "/etc/apache2/sites-enabled/"

  # Set bucket and object name
  obj = s3.buckets['ops-works-config'].objects['eu-prod.json']

  # Read content to variable
  file_content = obj.read

  # Log output (optional)
  # Chef::Log.info(file_content)

  sites = JSON.parse(file_content)
  sites['site'].each do |current|
    Chef::Log.info 'NOW WORKING ON: ' + current[1]['env']

    ruby_block 'create ssl dir' do
      block do
        system 'mkdir', '-p', "/var/cert/" + current[1]['env']
      end
      not_if { ::File.exists?("/var/cert/" + current[1]['env']) }
    end

    #Get SSL
    obj_chn = s3.buckets['ops-works-config'].objects["ssl/" + current[1]['ssl_folder'] + "/server.chn"]
    obj_crt = s3.buckets['ops-works-config'].objects["ssl/" + current[1]['ssl_folder'] + "/server.crt"]
    obj_key = s3.buckets['ops-works-config'].objects["ssl/" + current[1]['ssl_folder'] + "/server.key"]

    file_content_chn = obj_chn.read
    file_content_crt = obj_crt.read
    file_content_key = obj_key.read

    file "/var/cert/" + current[1]['env'] + "/server.chn" do
      content file_content_chn
      action :create
    end

    file "/var/cert/" + current[1]['env'] + "/server.crt" do
      content file_content_crt
      action :create
    end

    file "/var/cert/" + current[1]['env'] + "/server.key" do
      content file_content_key
      action :create
    end

    #Get vhost and write to file
    tmp_vhost_bucket = vhost_bucket + current[1]['vhost_template']
    obj_vhost = s3.buckets['ops-works-config'].objects[tmp_vhost_bucket]
    file_content = obj_vhost.read

    new_contents = file_content.gsub("PATH", "#{deploy[:deploy_to]}")
    new_contents = new_contents.gsub("URL", current[1]['url'])
    new_contents = new_contents.gsub("APP", current[1]['web_app'])
    new_contents = new_contents.gsub("LOG", current[1]['app_folder'])
    file_content = new_contents.gsub("SSL2", current[1]['env'])

    tmp_vhost_path = vhost_path + current[1]['vhost']
    file tmp_vhost_path do
      content file_content
      action :create
    end

    #Get web app file
    obj_app = s3.buckets['ops-works-config'].objects["prod_apps/" + current[1]['web_app']]
    file_content_app = obj_app.read
    file "#{deploy[:deploy_to]}/current/web/" + current[1]['web_app'] do
      content file_content_app
      action :create
    end

    #Update Host file
    ruby_block 'addHostData' do
      block do
        File.open('/etc/hosts', 'a+') do |hosts|
          hosts.puts("127.0.0.1 #{current[1]['url']}")
        end
      end
      only_if { ::File.exists?("/etc/hosts")}
    end

    #Create health
    ruby_block 'addHealthCheck' do
      block do
        text = File.read("#{deploy[:deploy_to]}/current/web/healthcheck.dist.php")
        new_contents = text.gsub("SERVER_ADDRESS", current[1]['url'])
        # To write changes to the file, use:
        File.open("#{deploy[:deploy_to]}/current/web/" + current[1]['env'] + ".php", "w") {|file| file.puts new_contents }
      end
      only_if { ::File.exists?("#{deploy[:deploy_to]}/current/web/healthcheck.dist.php") }
    end

    #Copy and update parameter file
    ruby_block 'testing' do
      block do
        text = File.read("#{deploy[:deploy_to]}/current/" + current[1]['app_folder'] + "/config/parameters.dist.yml")
        new_contents = text.gsub("YOUR_USER", current[1]['user'])
        new_contents = new_contents.gsub("YOUR_PASSWORD", current[1]['pass'])
        # To write changes to the file, use:
        File.open("#{deploy[:deploy_to]}/current/" + current[1]['app_folder'] + "/config/parameters.yml", "w") {|file| file.puts new_contents }
      end
      only_if { ::File.exists?("#{deploy[:deploy_to]}/current/" + current[1]['app_folder'] + "/config/parameters.dist.yml") }
    end

    script "install_remains" do
      interpreter "bash"
      user "root"
      cwd "#{deploy[:deploy_to]}/current"
      code <<-EOH

        php #{current[1]['app_folder']}/console assetic:dump --env=#{current[1]['env']}
        php #{current[1]['app_folder']}/console assets:install --env=#{current[1]['env']}
        php #{current[1]['app_folder']}/console doctrine:migrations:migrate --no-interaction --env=#{current[1]['env']}
        php #{current[1]['app_folder']}/console cache:clear --env=#{current[1]['env']} --no-debug --no-warmup
        chmod -R 777 #{current[1]['app_folder']}/cache
        chmod -R 777 #{current[1]['app_folder']}/logs

      EOH
      only_if { ::File.exists?("#{deploy[:deploy_to]}/current/composer.json") }
    end
  end
end
