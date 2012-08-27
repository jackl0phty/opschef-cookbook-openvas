Changes for OpenVAS cookbook version 0.0.52
===========================================
* Added Travis-ci integration.
* Bumped cookbook version.

Changes for OpenVAS cookbook version 0.0.48
===========================================

* Add scan_single_target.rb recipe.
* Add openvasknife.rb recipe.
* Add perl-XML-Twig to openvasknife.rb.

Changes for OpenVAS cookbook version 0.0.46
===========================================

* Fix role example in README.md

Changes for OpenVAS cookbook version 0.0.44
===========================================

* Change gsad to listen on default port 9392.
* Remove port 8080 from openvas_server role.
* Add nmap.rb to install Nmap version 6.
* Add openvas::nmap to openvas_server role run list.
* Fix install of Nmap version 6.
* Install alien package on Redhat.
* Add attribute nasl_no_signature_check to enable NVT signature check.
* Add attribute nasl_no_signature_check to openvas_server role.
* Add missing latex packages on Redhat to export reports in .pdf.

Changes for OpenVAS cookbook version 0.0.42
===========================================

* Add openvasmd -u -v to update_nvt.pl.
* update_nvt.pl now logs to /var/log/openvas/update_nvt.log.
* Add attribute ['openvas']['enable_greenbone_scan_configs']
* Add greenbone_scan_configs recipe.
* Create directory /var/lib/openvas/greenbone_scan_configs.
* Add the 5 default Greenbone scan configs to /var/lib/openvas/greenbone_scan_configs.
* Install Ruby gem openvas-omp.

Changes for OpenVAS cookbook version 0.0.40
===========================================

* Add alien package for Debian/Ubuntu platforms
* Fix auto starting the gsad service.
* Allow user to specify port for gsad service.

NOTE: A workaround was implemented for the gsad service 
because package libmicrohttpd on Redhat is not compiled
with HTTPS support. Workaround starts gsad service with
the --http-only and --port cmd line options.

Changes for OpenVAS cookbook version 0.0.38
===========================================

* Added CHANGES.md.
* Added service notifies when templates change.
* Edit README.md.
* Added supported INIT script options for required services.
* Added templates for gsad_log.conf, openvasad_log.conf, openvasmd_log.conf,
  openvassd.conf, and openvassd.rules config files.
* Added TODO.md.
