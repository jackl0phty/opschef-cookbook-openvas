#!/usr/bin/perl

###############################################################################
# The primary purpose of update_nvt.pl is to automatically update the         #
# Network Vulnerability Tests ( e.g. NVTs ) for OpenVAS.                      #
# OpenVAS, Open Vulnerability Assessment System, is a fork of the original    #
# Nessus project before they went closed source. OpenVAS, is by far, the best #
# Open source vulnerability scanner available on the web.                     #
#################$Author: Gerald L. Hevener, Jr., M.S. $#######################
#                        $Date: April 19, 2012 $                              #
#                            $Revision: #1 $                                  #
#                    $Id: /usr/local/bin/update_nvt.pl $                      #
#                  $HeadURL: /usr/local/bin/update_nvt.pl $                   #
#                  $Source: /usr/local/bin/update_nvt.pl $                    #
#         (C) 2011 : Gerald L. Hevener Jr., M.S. All Rights Reserved          #
#              (C) 2011 : jackl0phty.org All Rights Reserved                  #
#       Licensed under the Apache License, Version 2.0 (the "License")        #
#  For any questions regarding the license of this software, please refer to  #
#    the actual license at http://www.apache.org/licenses/LICENSE-2.0.txt.    #
###############################################################################
#                       DISCLAIMER OF WARRENTY                                #
# BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY FOR  #
# THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN        #
# OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES      #
# PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED #
# OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF        #
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE ENTIRE RISK AS TO #
# THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH YOU. SHOULD THE         #
# SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING,   #
# REPAIR, OR CORRECTION. IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR     #
# AGREED TO IN WRITING WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY  #
# MODIFY AND/OR REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE,  #
# BE LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,   #
# OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE THE     #
# SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING RENDERED  #
# INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIESOR A FAILURE OF THE   #
# SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF SUCH HOLDER OR OTHER  #
# PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.                  #
###############################################################################

# enable strict & warnings & version
use strict;
use warnings;
use version;

# Set variables
our $VERSION = '1.0.0';
my $date = `date`;

# Print date of NVT update
print "Updating OpenVAS NVT plugins on $date\n";

# Update OpenVAS NVTs
system( 'openvas-nvt-sync' );

# Print date of NVT cache update
print "Updating OpenVAS cache on $date\n";

# Update NVT cache. Required after running openvas-nvt-sync
system( 'openvasmd -u -v' );
