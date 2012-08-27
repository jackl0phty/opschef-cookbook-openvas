#
# Cookbook Name:: openvas 
# Attributes:: default 
# Copyright 2011, Gerald L. Hevener, Jr, M.S.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Set yes to append CRON job to crontab to update NVTs
set['openvas']['enable_nvt_updates_from_cron'] = "no"

# Set Perl location. Not used if ['openvas']['enable_nvt_updates_from_cron'] = "no"
set['openvas']['which_perl'] = "/usr/bin/perl"

# Set TCP port for the gsad service
set['openvas']['gsad_port'] = "9392"

# Set to yes to enable Greenbone scan configs
set['openvas']['enable_greenbone_scan_configs'] = "no"

# Set to no to enable NVT signature check.
set['openvas']['nasl_no_signature_check'] = "yes"

# Target to create ( e.g. Server you want to scan )
set['openvas']['target_to_create'] = "scanme.example.tld"

# Random pass is generated in server.rb
set['openvas']['openvas_admin_pass'] = ""
