#
# Cookbook Name:: openvas
# Recipe:: openvasknife
#
# Copyright 2011, Gerald L. Hevener Jr., M.S.
# License: Apache 2.0
#

include_recipe "perl"

case node['platform']
  when "redhat","centos","scientific","amazon","oracle"
    %w{perl-IPC-Run perl-version perl-XML-Twig}.each do |perlpkg|
      package perlpkg
    end
      cpan_module "Getopt::Declare"
  when "debian","ubuntu"
    %w{libgetopt-declare-perl libipc-run-perl libxml-twig-perl}.each do |perlpkg|
      package perlpkg
    end
end

cookbook_file "/usr/local/bin/openvasknife.pl" do
  mode "0755"
  owner "root"
  group "root"
end
