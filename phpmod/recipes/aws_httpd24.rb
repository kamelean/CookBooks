node[:deploy].each do |application, deploy|
  Chef::Log.info 'Installing httpd24'
  package 'httpd24' do
    action :install
  end
end