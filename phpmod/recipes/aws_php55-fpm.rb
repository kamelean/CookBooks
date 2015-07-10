node[:deploy].each do |application, deploy|
  Chef::Log.info 'Installing httpd and php'
  package 'php55-fpm' do
    action :install
  end
end