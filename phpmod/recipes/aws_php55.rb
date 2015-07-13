node[:deploy].each do |application, deploy|
  Chef::Log.info 'Installing php55'
  package 'php55' do
    action :install
  end
end