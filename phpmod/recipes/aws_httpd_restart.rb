node[:deploy].each do |application, deploy|
  Chef::Log.info 'Restarting Httpd'
  service "httpd" do
    action :restart
  end
end