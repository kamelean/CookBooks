
Chef::Log.info 'Installing php5-memcached'
package 'php5-memcached' do
  action :install
end
