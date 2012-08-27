#
# Cookbook Name:: openvas
# Recipe:: client
#
# Copyright 2011, Gerald L. Hevener Jr., M.S.
# License: Apache 2.0
#
case node['platform']

  when "ubuntu","debian","linuxmint"

    # Install OpenVAS PPA repo
    include_recipe "openvas::repo"

    # Add required packages to array 
    %w{ openvas-client greenbone-security-assistant gsd openvas-cli }.each do |pkg|
    package pkg

    end    

  when "redhat","centos","scientific","amazon"

    # Install OpenVAS PPA repo
    include_recipe "openvas::repo"

end
