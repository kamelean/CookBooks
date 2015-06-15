
pkg = value_for_platform_family(
    [ 'rhel', 'fedora' ] => 'php-intl',
    'debian' => 'php5-intl'
)

package pkg do
  action :install
  notifies(:run, "execute[/usr/sbin/php5enmod intl]", :immediately) if platform?('ubuntu') && node['platform_version'].to_f >= 12.04
end

execute '/usr/sbin/php5enmod intl' do
  action :nothing
  only_if { platform?('ubuntu') && node['platform_version'].to_f >= 12.04 && ::File.exists?('/usr/sbin/php5enmod') }
end