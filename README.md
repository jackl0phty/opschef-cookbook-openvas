Travis-ci status: [![Build Status](https://secure.travis-ci.org/jackl0phty/opschef-cookbook-openvas.png?branch=master)](http://travis-ci.org/jackl0phty/opschef-cookbook-openvas)

Description
===========

Install and configure OpenVAS ( Open Vulenability Assessment System ); a fork of the [Nessus] (http://www.nessus.org/products/nessus) project.

Project homepage can be found [here] (http://www.openvas.org/index.html) 

Requirements
============

It's recommended to create a role and apply it to your node definition.

Here's an exammple role to enable all things provided by this cookbook.
This is the recommended method. Note: Including recipe openvas::nmap before
openvas::server is required since it's a requirement.
<pre><code>
name "openvas_server"
description "Install & configure an OpenVAS server."
override_attributes "openvas" => { "enable_nvt_updates_from_cron" => "yes",
                    "gsad_port" => "9392", "enable_greenbone_scan_configs" => "yes",
                    "nasl_no_signature_check" => "no" }
run_list [
  "recipe[openvas::nmap]",
  "recipe[openvas::server]"
]
</pre></code>

Here's an example role to install an OpenVAS server.
<pre><code>
name "openvas_scanner"
description "Install/Configure an OpenVAS Server"
override_attributes "openvas_scanner" => { }
run_list [
  "recipe[openvas::nmap]",
  "recipe[openvas::server]"
]  
override_attributes "openvas_scanner" => { }
</pre></code>

Now upload your role like so:
<pre><code>
knife role from file roles/openvas_scanner.json
</pre></code>

Here's an example role to install an OpenVAS Scanner and automatically enable NVT updates.
<pre><code>
name "openvas_scanner"
description "Install/Configure an OpenVAS Server"
override_attributes "openvas" => { "enable_nvt_updates_from_cron" => "yes" }
run_list [
  "recipe[openvas::server]",
  "recipe[openvas::nmap]"
</pre></code>

Don't forget to apply your role to your node's definition
<pre><code>
{
    "normal": {
    },
    "name": "ovasscanner",
    "override": {
    },
        "prod_web": {
    },
    "json_class": "Chef::Node",
    "automatic": {
    },
    "run_list": [
                "role[openvas_scanner]"
    ],
    "chef_type": "node"
}
</pre></code>

Here's an example role to install only an OpenVAS client.
<pre><code>
name "openvas_client"
description "Install/Configure an OpenVAS client"
run_list "recipe[openvas::client]"
override_attributes "openvas_scanner" => { }
</pre></code>

Now upload your role like so:
<pre><code>
knife role from file roles/openvas_client.json
</pre></code>

NOTE ABOUT ADMIN/PASSWORD
=========================

The default admin user name and password is written
to /etc/openvas/openvas_admin_pass.txt.

Attributes
==========

Set to "yes" to add entry to super user root's CRON tab. 
<pre><code>
default['openvas']['enable_nvt_updates_from_cron'] = "yes"
</pre></code>
