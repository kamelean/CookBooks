node[:deploy].each do |application, deploy|
  Chef::Log.info 'Installing httpd and php'
  package ['httpd24' ,'php55', 'php55-mysqlnd', 'php55-xml', 'php55-mcrypt', 'php55-mbstring', 'php55-cli', 'mod24_ssl', 'php55-fpm', 'memcached', 'php55-pecl-apc', 'php55-pecl-memcached'] do
    action :install
  end
end