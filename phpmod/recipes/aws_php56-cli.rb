node[:deploy].each do |application, deploy|
  Chef::Log.info 'Installing php56-cli'
  package 'php56-cli' do
    action :install
  end
end