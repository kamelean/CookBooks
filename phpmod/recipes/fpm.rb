node[:deploy].each do |application, deploy|
  Chef::Log.info 'Installing php5-fpm'
  package 'php5-fpm' do
    action :install
  end
end
