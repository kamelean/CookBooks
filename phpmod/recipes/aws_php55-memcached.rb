node[:deploy].each do |application, deploy|
  Chef::Log.info 'Installing httpd and php'
  package 'php55' do
    action :install
  end
end