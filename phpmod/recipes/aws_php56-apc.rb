node[:deploy].each do |application, deploy|
  Chef::Log.info 'Installing php56-pecl-apc'
  package 'php56-pecl-apc' do
    action :install
  end
end