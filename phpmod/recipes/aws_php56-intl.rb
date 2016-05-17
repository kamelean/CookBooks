node[:deploy].each do |application, deploy|
  Chef::Log.info 'php56-intl'
  package 'php56-intl' do
    action :install
  end
end