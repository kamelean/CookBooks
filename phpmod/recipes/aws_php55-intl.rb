node[:deploy].each do |application, deploy|
  Chef::Log.info 'php55-intl'
  package 'php55-intl' do
    action :install
  end
end