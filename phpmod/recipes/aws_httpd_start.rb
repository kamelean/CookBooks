node[:deploy].each do |application, deploy|
  Chef::Log.info 'Starting Httpd'
  service "httpd" do
    action :start
  end
end