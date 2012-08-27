#
# Cookbook Name:: openvas
# Recipe:: default
#
# Copyright 2011, Gerald L. Hevener Jr., M.S.
# License: Apache 2.0
#
# Include openvas::client recipe
include_recipe "openvas::client"

# Add CRON job to update NVTs
if node['openvas']['enable_nvt_updates_from_cron'] == "yes"
  cookbook_file "/usr/local/bin/update_nvt.pl" do
  source "update_nvt.pl"
  owner "root"
  group "root"
  mode "0755"
  not_if 'test -f /usr/local/bin/update_nvt.pl'
  end
 
  cron "nvt_update" do
  minute "30"
  hour "3"
  day "*"
  month "*"
  weekday "*"
  command "perl /usr/local/bin/nvt_update.pl >> /var/log/openvas/update_nvt.log"
  user "root"
  mailto "root@localhost"
  shell "bash"
  end  
end
