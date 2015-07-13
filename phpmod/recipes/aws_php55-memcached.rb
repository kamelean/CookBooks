node[:deploy].each do |application, deploy|
  Chef::Log.info 'Installing php55-pecl-memcached'
  package 'php55-pecl-memcached' do
    action :install
  end
end