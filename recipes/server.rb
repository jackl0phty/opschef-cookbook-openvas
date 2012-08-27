#
# Cookbook Name:: openvas
# Recipe:: server
#
# Copyright 2011, Gerald L. Hevener Jr., M.S.
# License: Apache 2.0
#

# Install OpenVAS PPA repo & client
include_recipe "openvas::default"
include_recipe "openvas::client"
include_recipe "openvas::openvasknife"

# Install required Ruby gems
%w{ openvas-omp }.each do |gempkg|
  gem_package gempkg do
    action :install
  end
end

# Install OpenVAS server packages
case node['platform']

  when "ubuntu","debian","linuxmint"
    %w{ coreutils texlive-latex-base texlive-latex-extra texlive-latex-recommended htmldoc nsis
	openvas-manager openvas-scanner openvas-administrator sqlite3 xsltproc wget alien nikto }.each do |pkg|
    package pkg
  end

# Install OpenVAS server packages
  when "redhat","centos","scientific","amazon"

    %w{ nikto htmldoc tetex tetex-dvips tetex-fonts tetex-latex tetex-tex4ht
        passivetex }.each do |pkg|
    package pkg
    end
    
    # Install Nmap version 6
    include_recipe "openvas::nmap"

    # Install Alien
    execute "install-alien-on-redhat" do
      command "rpm -Uvh ftp://ftp.pbone.net/mirror/ftp.sourceforge.net/pub/sourceforge/p/po/postinstaller/data/alien-8.85-2.noarch.rpm"
      action :run
      not_if "rpm -qa |grep alien"
    end

    # Implement workaround for OpenVAS v5 bug
      execute "install-openvas-v4-x86_64" do
        command "rpm -Uvh http://www6.atomicorp.com/channels/atomic/centos/5/x86_64/RPMS/openvas-libraries-4.0.2-1.el5.art.x86_64.rpm;
                 rpm -Uvh http://www6.atomicorp.com/channels/atomic/centos/5/x86_64/RPMS/openvas-manager-2.0.4-3.el5.art.x86_64.rpm;
                 rpm -Uvh http://www6.atomicorp.com/channels/atomic/centos/5/x86_64/RPMS/xerces-c-2.8.0-4.el5.art.x86_64.rpm;
                 rpm -Uvh http://www6.atomicorp.com/channels/atomic/centos/5/x86_64/RPMS/xalan-c-1.10.0-6.el5.art.x86_64.rpm;
                 rpm -Uvh http://www6.atomicorp.com/channels/atomic/centos/5/x86_64/RPMS/ovaldi-5.6.4-1.el5.art.x86_64.rpm;
                 rpm -Uvh http://www6.atomicorp.com/channels/atomic/centos/5/x86_64/RPMS/openvas-scanner-3.2.2-3.el5.art.x86_64.rpm;
                 rpm -Uvh http://www6.atomicorp.com/channels/atomic/centos/5/x86_64/RPMS/openvas-cli-1.1.3-1.el5.art.x86_64.rpm;
                 rpm -Uvh http://www6.atomicorp.com/channels/atomic/centos/5/x86_64/RPMS/openvas-glib2-2.22.5-1.el5.art.x86_64.rpm;
                 rpm -Uvh http://www6.atomicorp.com/channels/atomic/centos/5/x86_64/RPMS/greenbone-security-assistant-2.0.1-4.el5.art.x86_64.rpm;
                 rpm -Uvh http://www6.atomicorp.com/channels/atomic/centos/5/x86_64/RPMS/openvas-1.0-0.5.el5.art.noarch.rpm;
                 rpm -Uvh http://www6.atomicorp.com/channels/atomic/centos/5/x86_64/RPMS/openvas-administrator-1.1.1-2.el5.art.x86_64.rpm;"
        action :run
        only_if "uname -a |grep x86_64"
        not_if "rpm -qa |grep openvas"
      end
    
      # Implement workaround for package libmicrohttpd not being compiled
      # with SSL support on Redhat.
      script "start-gsad-service" do
        interpreter "bash"
        user "root"
        cwd "/tmp"
        code <<-EOH
        /usr/sbin/gsad --http-only --port #{node['openvas']['gsad_port']}
        EOH
        not_if "ps aux |grep gsad |egrep -v grep"
      end
 
  end 

    # A bug in OpenVAS v5 causes it to fail to start on redhat.
    # Until fixed upstream, redhat users will get OpenVAS v4 instead. 
    #%w{ openvas }.each do |pkg|
    #package pkg 
  #end
  #execute "install-openvas-redhat" do
  #command "yum makecache; yum -y install openvas"
  #action :run
  #not_if "rpm -qa |grep openvas"
  #end

#end

cookbook_file "/usr/local/bin/openvas-check-setup" do
  source "openvas-check-setup"
  mode "0744"
end

# Create OpenVAS certificate
execute "openvas-mkcert" do
  command "openvas-mkcert -q"
  action :run
  not_if "test -e /var/lib/openvas/CA/cacert.pem"
end

# Create /var/lib/openvas/plugins
directory "/var/lib/openvas/plugins" do
  owner "root"
  group "root"
  mode "0755"
  action :create
  not_if "test -d /var/lib/openvas/plugins" 
end

# Update OpenVAS network vulnerability tests 
execute "openvas-nvt-sync" do
  command "openvas-nvt-sync; sleep 5m"
  action :run
  not_if "COUNT=`ls -alh /var/lib/openvas/plugins/a* |wc -l`; [ $COUNT -gt 50 ] && echo true; "
end

# Create SSL client certificate for user om
execute "openvas-mkcert-client" do
  command "openvas-mkcert-client -n om -i"
  action :run
  not_if "test -d /var/lib/openvas/users/om"
end

# Migrate/rebuild database on 1st run
execute "openvassd" do
  command "openvassd"
  user	  "root"
  action :run
  not_if "netstat -nlp |grep openvassd"
end

# Rebuild openvasmd-rebuild
execute "openvasmd-rebuild" do
  command "openvasmd --rebuild"
  user    "root"
  action :run
  not_if "test -d /var/lib/openvas/users/admin"
end

# Execute killall openvassd
execute "killall-openvassd" do
  command "killall openvassd"
  user    "root"
  action :run
  not_if "test -d /var/lib/openvas/users/admin"
end

# Sleep for 15 seconds
execute "sleep" do
  command "sleep 15"
  user    "root"
  action :run
  not_if "test -d /var/lib/openvas/users/admin"
end

# Enable & start openvas-scanner service
service "openvas-scanner" do
  supports :start => true, :stop => true, :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

# Enable & start openvas-manager service
service "openvas-manager" do
  supports :start => true, :stop => true, :status => true, :restart => true, :reload => false, :condrestart => true
  action [ :enable, :start ]
end

# Enable & start openvas-administrator service
service "openvas-administrator" do
  supports :start => true, :stop => true, :status => true, :restart => true, :reload => false, :condrestart => true
  action [ :enable, :start ]
end

# Enable & start greenbone-security-assistant service
service "gsad" do
  supports :start => true, :stop => true, :status => true, :restart => true, :reload => true
  action [ :enable, :start ]  
end

# Generate random password, assign to admin openvas account
# and write password to /tmp/openvas_admin_pass.txt.
ruby_block "gen_rand_openvas_pass" do
  block do
    def newpass( len )
      
      # Set list of chars to include in pseudo-random password
      chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
      newpass = ""
      1.upto(len) { |i| newpass << chars[rand(chars.size)] }
      return newpass

    end

    # Set password length to 12 chars
    pass = newpass(12)

    # Write random password to file
    f = File.new( "/etc/openvas/openvas_admin_pass.txt", "w" )
    f.puts( "This is username & password for the OpenVAS admin account.\n" )
    f.puts( "Generated by Opscode Chef!\n" )
    f.puts( "Username: admin Password: #{pass}" )
    f.close

    system( "openvasad -c add_user -n admin -r Admin -w #{pass}" )
    system( "chmod 0640 /etc/openvas/openvas_admin_pass.txt" )

  end
  action :create
  not_if "test -e /etc/openvas/openvas_admin_pass.txt"
end

# Add template for /etc/openvas/gsad_log.conf
template "/etc/openvas/gsad_log.conf" do
  source "gsad_log.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  not_if "test -f /etc/openvas/gsad_log.conf"
  notifies :reload, "service[gsad]", :immediately
end

# Add template for /etc/openvas/openvasad_log.conf
template "/etc/openvas/openvasad_log.conf" do
  source "openvasad_log.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, "service[openvas-administrator]", :immediately
end

# Add template for /etc/openvas/openvasmd_log.conf
template "/etc/openvas/openvasmd_log.conf" do
  source "openvasmd_log.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, "service[openvas-manager]", :immediately
end

# Add template for /etc/openvas/openvassd.conf
template "/etc/openvas/openvassd.conf" do
  source "openvassd.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :reload, "service[openvas-scanner]", :immediately
end

# Add template for /etc/openvas/openvassd.rules
template "/etc/openvas/openvassd.rules" do
  source "openvassd.rules.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :reload, "service[openvas-scanner]", :immediately
end

# Check if Greenbone scan configs are enable
if node['openvas']['enable_greenbone_scan_configs'] == "yes"

  # Include Greenbone scan configs
  include_recipe "openvas::greenbone_scan_configs"

end
