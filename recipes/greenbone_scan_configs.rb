#
# Cookbook Name:: openvas
# Recipe:: greenbone_scan_configs
#
# Copyright 2011, Gerald L. Hevener Jr., M.S.
# License: Apache 2.0
#

# Create /var/lib/openvas/greenbone_scan_configs
directory "/var/lib/openvas/greenbone_scan_configs" do
  owner "root"
  group "root"
  mode "0755"
  action :create
  not_if "test -d /var/lib/openvas/greenbone_scan_configs"
end

# Download greenbone config for conficker non-invasive
remote_file "/var/lib/openvas/greenbone_scan_configs/conficker-search-scanconfig.xml" do
  source "http://greenbone.net/download/conficker-search-scanconfig.xml"
  mode "0644"
  owner "root"
  group "root"
  checksum "1340a3388793aaf77dc16bc9533a8691"
  not_if "test -f /var/lib/openvas/greenbone_scan_configs/conficker-search-scanconfig.xml"
end

# Download greenbone config for conficker invasive
remote_file "/var/lib/openvas/greenbone_scan_configs/conficker-search-scanconfig-invasive.xml" do
  source "http://greenbone.net/download/conficker-search-scanconfig-invasive.xml"
  mode "0644"
  owner "root"
  group "root"
  checksum "5694f1419febf0dadf8995e561014afc"
  not_if "test -f /var/lib/openvas/greenbone_scan_configs/conficker-search-scanconfig-invasive.xml"
end

# Download greenbone config for Full-and-fast-all-IPs.xml
remote_file "/var/lib/openvas/greenbone_scan_configs/Full-and-fast-all-IPs.xml" do
  source "http://greenbone.net/download/Full-and-fast-all-IPs.xml"
  mode "0644"
  owner "root"
  group "root"
  checksum "9382e15ea7cefe95a36905c6c0aa393b"
  not_if "test -f /var/lib/openvas/greenbone_scan_configs/Full-and-fast-all-IPs.xml"
end

# Download greenbone config for Full-and-fast-with-NTLMSSP.xml
remote_file "/var/lib/openvas/greenbone_scan_configs/Full-and-fast-with-NTLMSSP.xml" do
  source "http://greenbone.net/download/Full-and-fast-with-NTLMSSP.xml"
  mode "0644"
  owner "root"
  group "root"
  checksum "1a1a480b40557846a1747f2bc29fe57e"
  not_if "test -f /var/lib/openvas/greenbone_scan_configs/Full-and-fast-with-NTLMSSP.xml"
end

# Download greenbone config for it-grundschutz-el11
remote_file "/var/lib/openvas/greenbone_scan_configs/it-grundschutz-el11.xml" do
  source "http://greenbone.net/download/it-grundschutz-el11.xml"
  mode "0644"
  owner "root"
  group "root"
  checksum "75a60ebfccae8f4a8eec8268202bf50a"
  not_if "test -f /var/lib/openvas/greenbone_scan_configs/it-grundschutz-el11.xml"
end

# Download greenbone config for nmap-nse.xml
remote_file "/var/lib/openvas/greenbone_scan_configs/nmap-nse.xml" do
  source "http://greenbone.net/download/nmap-nse.xml"
  mode "0644"
  owner "root"
  group "root"
  checksum "8835409c3f5450b1dfddb73de3526a36"
  not_if "test -f /var/lib/openvas/greenbone_scan_configs/nmap-nse.xml"
end

# Download greenbone config for offline-unixoid-lsc.xml
remote_file "/var/lib/openvas/greenbone_scan_configs/offline-unixoid-lsc.xml" do
  source "http://greenbone.net/download/offline-unixoid-lsc.xml"
  mode "0644"
  owner "root"
  group "root"
  checksum "422539f81312028f0ef4b3dc8edd410f"
  not_if "test -f /var/lib/openvas/greenbone_scan_configs/offline-unixoid-lsc.xml"
end

# Download greenbone config for collect-oval-sc.xml
remote_file "/var/lib/openvas/greenbone_scan_configs/collect-oval-sc.xml" do
  source "http://greenbone.net/download/collect-oval-sc.xml"
  mode "0644"
  owner "root"
  group "root"
  checksum "76323a44508d8e2002b282477f540c21"
  not_if "test -f /var/lib/openvas/greenbone_scan_configs/collect-oval-sc.xml"
end

# Download greenbone config for pci-dss.xml
remote_file "/var/lib/openvas/greenbone_scan_configs/pci-dss.xml" do
  source "http://greenbone.net/download/pci-dss.xml"
  mode "0644"
  owner "root"
  group "root"
  checksum "ea1781d09cf6608eee64decd27b23aaf"
  not_if "test -f /var/lib/openvas/greenbone_scan_configs/pci-dss.xml"
end

# Download greenbone config for stuxnet-search-scanconfig.xml
remote_file "/var/lib/openvas/greenbone_scan_configs/stuxnet-search-scanconfig.xml" do
  source "http://greenbone.net/download/stuxnet-search-scanconfig.xml"
  mode "0644"
  owner "root"
  group "root"
  checksum "49e4bd369f721836465cadb6d840de04"
  not_if "test -f /var/lib/openvas/greenbone_scan_configs/stuxnet-search-scanconfig.xml"
end

# Download greenbone config for web-app-scan.xml
remote_file "/var/lib/openvas/greenbone_scan_configs/web-app-scan.xml" do
  source "http://greenbone.net/download/web-app-scan.xml"
  mode "0644"
  owner "root"
  group "root"
  checksum "38057b1f5258d12024f951dcff438877"
  not_if "test -f /var/lib/openvas/greenbone_scan_configs/web-app-scan.xml"
end

# Copy greenbone config for empty-default.xml
cookbook_file "/var/lib/openvas/greenbone_scan_configs/empty-default.xml" do
  source "empty-default.xml"
  mode "0644"
  owner "root"
  group "root"
  not_if "test -f /var/lib/openvas/greenbone_scan_configs/empty-default.xml"
end

# Copy greenbone config for full-and-deep-default.xml
cookbook_file "/var/lib/openvas/greenbone_scan_configs/full-and-deep-default.xml" do
  source "full-and-deep-default.xml"
  mode "0644"
  owner "root"
  group "root"
  not_if "test -f /var/lib/openvas/greenbone_scan_configs/full-and-deep-default.xml"
end

# Copy greenbone config for full-and-fast-default.xml
cookbook_file "/var/lib/openvas/greenbone_scan_configs/full-and-fast-default.xml" do
  source "full-and-fast-default.xml"
  mode "0644"
  owner "root"
  group "root"
  not_if "test -f /var/lib/openvas/greenbone_scan_configs/full-and-fast-default.xml"
end

# Copy greenbone config for full-and-fast-ultimate-default.xml
cookbook_file "/var/lib/openvas/greenbone_scan_configs/full-and-fast-ultimate-default.xml" do
  source "full-and-fast-ultimate-default.xml"
  mode "0644"
  owner "root"
  group "root"
  not_if "test -f /var/lib/openvas/greenbone_scan_configs/full-and-fast-ultimate-default.xml"
end

# Copy greenbone config for full-and-very-deep-ultimate-default.xml
cookbook_file "/var/lib/openvas/greenbone_scan_configs/full-and-very-deep-ultimate-default.xml" do
  source "full-and-very-deep-ultimate-default.xml"
  mode "0644"
  owner "root"
  group "root"
  not_if "test -f /var/lib/openvas/greenbone_scan_configs/full-and-very-deep-ultimate-default.xml"
end
