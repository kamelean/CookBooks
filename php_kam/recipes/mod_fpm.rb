case node['platform_family']
  when 'rhel', 'fedora'
    pearhub_chan = php_pear_channel 'pearhub.org' do
      action :discover
    end
    php_pear 'FPDF' do
      channel pearhub_chan.channel_name
      action :install
    end
  when 'ubuntu'
    package 'php5-fpm' do
      action :install
    end
end