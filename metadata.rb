maintainer       "Gerald L. Hevener Jr., M.S."
maintainer_email "jackl0phty@gmail.com"
license          "Apache 2.0"
description      "Installs/Configures openvas"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.52"
recipe           "openvas", "Default recipe. Does nothing by default."
recipe           "openvas::client", "Installs repo & the OpenVAS client."
recipe           "openvas::repo", "Installs the OpenVAS YUM repo."
recipe           "openvas::greenbone_scan_configs", "Downloads greenbone scan configs."
recipe           "openvas::nmap", "Install port scanner Nmap."
recipe           "openvas::openvasknife", "Install Perl cmd-line utility openvasknife."
recipe           "openvas::scan_single_target", "Used openvasknife to scan a target."
recipe           "openvas::server", "Install the OpenVAS server."

%w{ apt perl openvas }.each do |cb|
  depends cb
end
