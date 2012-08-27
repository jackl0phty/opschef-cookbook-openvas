#
# Cookbook Name:: openvas
# Recipe:: nmap 
#
# Copyright 2011, Gerald L. Hevener Jr., M.S.
# License: Apache 2.0

# It's recommended to have at least Nmap version
# 5.51 for complete OpenVAS support.
case node['platform']

  when "redhat","centos","scientific","amazon"

    # Install subversion client
    %w{ subversion }.each do |pkg|
    package pkg
    end

    # INstall Nmap version 6 on x86
    if node['target_cpu'] = "x86" 
    
      execute "install-nmap-version-6-x86" do
        command "rpm -Uvh http://nmap.org/dist/nmap-6.00-1.i386.rpm"
        action :run
        not_if "nmap --version |grep 6.00"
      end

    end  

    # INstall Nmap version 6 on x86_64
    if node['target_cpu'] = "x86_64"
    
      execute "install-nmap-version-6-x86_64" do
        command "rpm -Uvh http://nmap.org/dist/nmap-6.00-1.x86_64.rpm"
        action :run
        not_if "nmap --version |grep 6.00"
      end

    end

  end
