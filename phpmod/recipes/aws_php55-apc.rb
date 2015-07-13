node[:deploy].each do |application, deploy|
  Chef::Log.info 'Installing php55-pecl-apc'
  package 'php55-pecl-apc' do
    action :install
  end
end