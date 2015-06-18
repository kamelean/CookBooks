Chef::Log.info 'Installing php5-intl'
package 'php5-intl' do
  action :install
end