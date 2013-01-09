#
# Cookbook Name:: timezone
# Recipe:: default
#
# Copyright 2010, James Harton <james@sociable.co.nz>
#
# Apache 2.0 License.
#

case node['platform_family']
when "debian"
  # Make sure it's installed. It would be a pretty broken system
  # that didn't have it.
  package "tzdata"

  template "/etc/timezone" do
    source "timezone.conf.erb"
    owner "root"
    group "root"
    mode 00644
    notifies :run, 'bash[dpkg-reconfigure tzdata]'
  end

  bash 'dpkg-reconfigure tzdata' do
    user 'root'
    code "/usr/sbin/dpkg-reconfigure -f noninteractive tzdata"
    action :nothing
  end

when "fedora", "rhel"
  package "tzdata"

  link "/etc/localtime" do
    to "/usr/share/zoneinfo/#{node['tz']}"
  end

  file "/etc/sysconfig/clock" do
    owner "root"
    group "root"
    mode 00644
    content 'ZONE="' + node['tz'] + '"'
    action :create
  end

end
