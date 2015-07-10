node[:deploy].each do |application, deploy|
  Chef::Log.info 'Installing httpd and php'
  package 'httpd24' do
    action :install
  end
end