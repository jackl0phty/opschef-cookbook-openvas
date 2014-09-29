#
# Cookbook Name:: openvas
# Recipe:: source
#
# Copyright 2014, Gerald L. Hevener Jr., M.S.
# License: Apache 2.0
#

# Download OpenVAS libraries.
remote_file "#{Chef::Config[:file_cache_path]}/openvas-libraries-7.0.4.tar.gz" do
  source 'http://wald.intevation.org/frs/download.php/1722/openvas-libraries-7.0.4.tar.gz'
  action :create_if_missing
end

# Download OpenVAS scanner.
remote_file "#{Chef::Config[:file_cache_path]}/openvas-scanner-4.0.3.tar.gz" do
  source 'http://wald.intevation.org/frs/download.php/1726/openvas-scanner-4.0.3.tar.gz'
  action :create_if_missing
end

# Download OpenVAS manager.
remote_file "#{Chef::Config[:file_cache_path]}/openvas-manager-5.0.4.tar.gz" do
  source 'http://wald.intevation.org/frs/download.php/1730/openvas-manager-5.0.4.tar.gz'
  action :create_if_missing
end

# Download OpenVAS GSA ( Greenbone Security Assistant ).
remote_file "#{Chef::Config[:file_cache_path]}/greenbone-security-assistant-5.0.3.tar.gz" do
  source 'http://wald.intevation.org/frs/download.php/1734/greenbone-security-assistant-5.0.3.tar.gz'
  action :create_if_missing
end

# Download OpenVAS CLI ( Command Line Interface ).
remote_file "#{Chef::Config[:file_cache_path]}/openvas-cli-1.3.0.tar.gz" do
  source 'http://wald.intevation.org/frs/download.php/1633/openvas-cli-1.3.0.tar.gz'
  action :create_if_missing
end
