node[:deploy].each do |application, deploy|
  Chef::Log.info 'Installing php56-pdo'
  package 'php56-pdo' do
    action :install
  end
end