#
# Cookbook Name:: openvas
# Recipe:: scan_single_target
#
# Copyright 2011, Gerald L. Hevener Jr., M.S.
# License: Apache 2.0
#

# require 'rubygems' # if using Ruby <1.9
#require 'openvas-omp'

# Define variables
#ov=OpenVASOMP::OpenVASOMP.new("user"=>'openvas',"password"=>'openvas')
#config=ov.config_get().index("Full and fast")
#target=ov.target_create({"name"=>"127.0.0.1", "hosts"=>"127.0.0.1", "comment"=>"Scan Localhost"})
#taskid=ov.task_create({"name"=>"scan-localhost","comment"=>"Scan Localhost", "target"=>target, "config"=>config})
#ov.task_start(taskid)

# Begin Scan
#while not ov.task_finished(taskid) do
#        stat=ov.task_get_byid(taskid)
#        puts "Status: #{stat['status']}, Progress: #{stat['progress']} %"
#        sleep 10
#end

# Get task by taskid
#stat=ov.task_get_byid(taskid)

# Prepare HTML report
#content=ov.report_get_byid(stat["lastreport"],'HTML')

# Create html scan report
#File.open('report.html', 'w') {|f| f.write(content) }

# Always close file handles
#File.close

script "add_openvas_target_to_scan" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  perl /usr/local/bin/openvasknife.pl --user admin --pass #{node['openvas']['openvas_admin_pass']} --addt #{node['openvas']['target_to_create']}
  EOH
  action :run
end

# Remove scan_single_target from node's runlist
ruby_block "remove_scan_single_target_from_runlist" do
  block do
    Chef::Log.info("OpenVAS vulnerability scan complete, removing recipe[openvas::scan_single_target] from runlist.")
    node.run_list.remove("recipe[openvas::scan_single_target]") if node.run_list.include?("recipe[openvas::scan_single_target]")
  end
  action :nothing
end
