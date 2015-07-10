node[:deploy].each do |application, deploy|
  Chef::Log.info 'Installing httpd and php'
  package 'mod24_ssl' do
    action :install
  end
end