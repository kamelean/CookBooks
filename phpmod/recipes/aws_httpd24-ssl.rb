node[:deploy].each do |application, deploy|
  Chef::Log.info 'Installing httpd mod24_ssl'
  package 'mod24_ssl' do
    action :install
  end
end