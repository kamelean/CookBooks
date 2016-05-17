node[:deploy].each do |application, deploy|
  Chef::Log.info 'Installing php56-pecl-memcached'
  package 'php56-pecl-memcached' do
    action :install
  end
end