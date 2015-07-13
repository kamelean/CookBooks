node[:deploy].each do |application, deploy|
  Chef::Log.info 'Installing php55-mbstring'
  package 'php55-mbstring' do
    action :install
  end
end