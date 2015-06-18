#
# Taken from:
# http://docs.aws.amazon.com/opsworks/latest/userguide/gettingstarted.walkthrough.photoapp.3.html
#
node[:deploy].each do |application, deploy|
  script "install_composer" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current"
    code <<-EOH

    php composer.phar self-update
    php composer.phar install --prefer-dist --no-scripts --optimize-autoloader --no-scripts
    EOH
    only_if { ::File.exists?("#{deploy[:deploy_to]}/current/composer.json") }
  end
end