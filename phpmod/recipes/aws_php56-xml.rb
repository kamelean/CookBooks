node[:deploy].each do |application, deploy|
  Chef::Log.info 'Installing php56-xml'
  package 'php56-xml' do
    action :install
  end
end