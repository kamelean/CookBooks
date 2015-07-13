node[:deploy].each do |application, deploy|
  Chef::Log.info 'Installing php55-fpm'
  package 'php55-fpm' do
    action :install
  end
end