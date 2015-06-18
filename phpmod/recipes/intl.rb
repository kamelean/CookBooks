node[:deploy].each do |application, deploy|
  Chef::Log.info 'Installing php5-intl'

  script "install_php_mods" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current"
    code <<-EOH
    apt-get install php5-intl

    EOH
  end

  #package 'php5-intl' do
  #  action :install
  #end
end
