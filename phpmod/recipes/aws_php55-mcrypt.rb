node[:deploy].each do |application, deploy|
  Chef::Log.info 'Installingphp55-mcrypt'
  package 'php55-mcrypt' do
    action :install
  end
end