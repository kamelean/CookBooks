node[:deploy].each do |application, deploy|
  Chef::Log.info 'Installing php55-pdo'
  package 'php55-pdo' do
    action :install
  end
end