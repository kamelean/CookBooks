case node['platform_family']
  when 'rhel', 'fedora'
    %w{ zlib-devel }.each do |pkg|
      package pkg do
        action :install
      end
    end
    php_pear 'memcache' do
      action :install
      # directives(:shm_size => "128M", :enable_cli => 0)
    end
  when 'ubuntu'
    package 'php5-memcached' do
      action :install
    end
end