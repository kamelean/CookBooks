
Chef::Log.info 'Installing php5-memcached'
package 'php5-memcache' do
  action :install
end
