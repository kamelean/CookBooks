node[:deploy].each do |application, deploy|
  Chef::Log.info 'Installing php56-fpm'
  package 'php56-fpm' do
    action :install
  end
  Chef::Log.info 'Starting php56-fpm'
  service "php-fpm" do
    action :start
  end
end