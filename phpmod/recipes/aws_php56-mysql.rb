node[:deploy].each do |application, deploy|
  Chef::Log.info 'Installing php56-mysqlnd'
  package 'php56-mysqlnd' do
    action :install
  end
end