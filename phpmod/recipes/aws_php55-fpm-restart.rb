node[:deploy].each do |application, deploy|
  Chef::Log.info 'Restarting php55-fpm'
  service "php-fpm" do
    action :restart
  end
end