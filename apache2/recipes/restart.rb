include_recipe "apache2::service"

service "apache24" do
  action :start
end