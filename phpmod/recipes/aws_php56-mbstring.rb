node[:deploy].each do |application, deploy|
  Chef::Log.info 'Installing php56-mbstring'
  package 'php56-mbstring' do
    action :install
  end
end