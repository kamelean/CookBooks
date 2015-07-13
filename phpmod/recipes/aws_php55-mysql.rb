node[:deploy].each do |application, deploy|
  Chef::Log.info 'Installing php55-mysqlnd'
  package 'php55-mysqlnd' do
    action :install
  end
end