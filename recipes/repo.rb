#
# Cookbook Name:: openvas
# Recipe:: repo
#
# Copyright 2011, Gerald L. Hevener Jr., M.S.
# License: Apache 2.0
#

# Check if platform is Debian
if node['platform'] == 'debian' or node['platform'] == 'ubuntu' or node['platform'] == 'linuxmint'

  # Load Apt cookbook
  include_recipe "apt"

  # Install python-software-properties
  package "python-software-properties" do
    action :install
  end

# Add OpenVAS PPA. Get key from keyserver
apt_repository "openvas-repo" do
  uri "http://download.opensuse.org/repositories/security:/OpenVAS:/STABLE:/v4/xUbuntu_11.10/ ./"
  keyserver "hkp://keys.gnupg.net"
  key "BED1E87979EAFD54"
  action :add
  not_if "apt-key list |grep -i opscode"
  end

end


# A bug in OpenVAS v5 causes it to fail to start on redhat.
# This repo will reamin disabled until that is fixed.
# Instead, redhat users will get OpenVAS v4 instead.

# Check if platform is Redhat
#if node['platform'] == 'redhat' or node['platform'] == 'centos' or node['platform'] == 'scientific' or node['platform'] == 'amazon'

# Deploy Atomicorp repo install script
#cookbook_file "/tmp/install_atomicorp_repo.sh" do
#  mode 0755
#  owner "root"
#  group "root"
#  source "install_atomicorp_repo.sh"
#  not_if "rpm -qa |grep atomic-release"
#end

# A bug in OpenVAS v5 causes it to fail to start on redhat.
# This repo will reamin disabled until that is fixed.
# Instead, redhat users will get OpenVAS v4 instead.

# Add Atomicorp repo
#execute "install-atomicorp-repo" do
#  user "root"
#  group "root"
#  command "sh /tmp/install_atomicorp_repo.sh; rm -f /tmp/install_atomicorp_repo.sh"
#  action :run
#  not_if "rpm -qa |grep atomic-release"
#  end

#end
