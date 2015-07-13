node[:deploy].each do |application, deploy|
  Chef::Log.info 'Installing php55-xml'
  package 'php55-xml' do
    action :install
  end
end