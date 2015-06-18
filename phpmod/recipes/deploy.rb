include_recipe 'deploy'

node[:deploy].each do |application, deploy|
  Chef::Log.info 'opsworks_deploy going_on'
  opsworks_deploy do
    deploy_data deploy
    app application
  end
end