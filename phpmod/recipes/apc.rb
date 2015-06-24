node[:deploy].each do |application, deploy|
  Chef::Log.info 'Installing php5-fpm'
  package 'php-apc' do
    action :install
  end
end
