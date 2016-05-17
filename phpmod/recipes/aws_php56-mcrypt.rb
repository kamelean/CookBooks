node[:deploy].each do |application, deploy|
  Chef::Log.info 'Installingphp56-mcrypt'
  package 'php56-mcrypt' do
    action :install
  end
end