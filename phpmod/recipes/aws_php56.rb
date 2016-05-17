node[:deploy].each do |application, deploy|
  Chef::Log.info 'Installing php56'
  package 'php56' do
    action :install
  end
end