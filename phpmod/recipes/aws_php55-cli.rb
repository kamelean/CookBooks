node[:deploy].each do |application, deploy|
  Chef::Log.info 'Installing php55-cli'
  package 'php55-cli' do
    action :install
  end
end