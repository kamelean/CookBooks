
Chef::Log.info 'Installing php5-memcached'
package 'memcached' do
  action :install
end
