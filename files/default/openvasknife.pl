#!/usr/bin/perl

###############################################################################
# The primary purpose of openvasknife.pl is to provide a Perl cmd-line        #
# utility which acts as a wrapper around openvas-cli. This is used to         #
# automate vulnerability scans with Opscode Chef.                             #
#################$Author: Gerald L. Hevener, Jr., M.S. $#######################
#                        $Date: May 30, 2012 $                                #
#                            $Revision: #1 $                                  #
#                   $Id: /usr/local/bin/openvasknife.pl $                     #
#                 $HeadURL: /usr/local/bin/openvasknife.pl $                  #
#                   $Source: /usr/local/bin/openvasknife.pl $                 #
#        (C) 2011 : Gerald L. Hevener Jr., M.S. All Rights Reserved           #
#        (C) 2011 : jackl0phty.org All Rights Reserved                        #
#       Licensed under the Apache License, Version 2.0 (the "License"),       #
# For any questions regarding the license of this software, please refer to   #
# the actual license at http://www.apache.org/licenses/LICENSE-2.0.txt.       #
###############################################################################
#                        DISCLAIMER OF WARRENTY                               #
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
################# USE THIS SOFTWARE AT YOUR OWN RISK!!!!#######################
###############################################################################

# Let's be strict and warn
use strict;
use warnings;

# Import required modules
use Getopt::Declare;
use Carp;
use version;
use IPC::Run qw ( run timeout );

# ldapknife.pl VERSION
our $VERSION = qv(1.0.0);

# Declare variables
my $openvas_user;
my $openvas_pass;
my $target_to_add;
my $target_to_scan;
my $task_to_add;
my @openvas_cmd;
my $comment;
my $task_comment;
my $config_id;
my $scan_config;
my $target_id;

# Specify the usage specification for the program
my $specification = <<'USAGE_SPEC';
  --user	Username for OpenVAS admin
  --pass	Password for OpenVAS admin
  --tcomment	Comment for new task
  --cid		Scan config id to use with new task
  --tid		Target id to use with new task
  --tscan	Target to scan
  --help	Print USAGE page
	{ $self->usage(0); }
  -help		[ditto]
  --addt	Name of target to create
	{ create_target() }
  --addtask	Name of task to create
	{ create_task() }
  --sconfig	Scan config type
  --		End of argument list
		{ finish }
USAGE_SPEC

# Automatically generate help, usage, & version information
# See specification above for details
my $args = Getopt::Declare->new($specification);

# If number of options < 1 print USAGE
if ( $#ARGV < 1 ) {

    print $args->usage() or croak 'Couldn\'t print tool usage';

}

##################MAIN PROGRAM LOGIC######################


##################MAIN PROGRAM LOGIC######################

sub get_cmd_line_options {

    # Get cmd line options
    foreach my $option ( 0 .. $#ARGV ) {

        # Get --addt option
        if ( $ARGV[$option] =~ m/--addt/gmx ) {

            $target_to_add = $ARGV[ $option + 1 ];

            # Uncomment next line to debug
            #print "\$target_to_add = $target_to_add\n";

        }

        # --user
        if ( $ARGV[$option] =~ m/--user/gmx ) {

            $openvas_user = $ARGV[ $option + 1 ];

            # Uncomment next line to debug
            #print "\$openvas_user = $openvas_user\n";

        }
        
        if ( $ARGV[$option] =~ m/--pass/gmx ) {

            $openvas_pass = $ARGV[ $option + 1 ];

            # Uncomment next line to debug
            #print "\$openvas_pass = $openvas_pass\n";

        }

        if ( $ARGV[$option] =~ m/--addtask/gmx ) {

            $task_to_add = $ARGV[ $option + 1 ];

            # Uncomment next line to debug
            #print "\$task_to_add = $task_to_add\n";

        }

        if ( $ARGV[$option] =~ m/--tcomment/gmx ) {

            $task_comment = $ARGV[ $option + 1 ];

            # Uncomment next line to debug
            #print "\$task_comment = $task_comment\n";

        }

         if ( $ARGV[$option] =~ m/--sconfig/gmx ) {

            $scan_config = $ARGV[ $option + 1 ];

            # Uncomment next line to debug
            #print "\$scan_config = $scan_config\n";

        }        

	if ( $ARGV[$option] =~ m/--tscan/gmx ) {

            $target_to_scan = $ARGV[ $option + 1 ];

            # Uncomment next line to debug
            print "\$target_to_scan = $target_to_scan\n";	
 
	}

        # End foreach loop
        }	

    # End sub with a return
    return;

    # End sub get_cmd_line_options
}

sub create_target {

    # Get command line options
    get_cmd_line_options();

    #Uncomment to debug
    #print "\$openvas_user = $openvas_user\n";
    #print "\$openvas_pass = $openvas_pass\n";
    #print "\$target_to_add = $target_to_add\n";
    
    # Build OpenVAS cmd
    @openvas_cmd = "omp -u $openvas_user -w $openvas_pass --xml=\"<create_target><name>$target_to_add</name><hosts>$target_to_add</hosts></create_target>\"";

    # Enable for debugging
    print "\@openvas_cmd = @openvas_cmd\n";

    # Execute OpenVAS cmd
    run @openvas_cmd  or croak "omp: $?\n";

    # End sub with a return
    return;

    # End sub create_target 

}

sub create_task {

    # Get command line options
    get_cmd_line_options();

    # Get scan config id
    #get_scan_config_id();	

    # Get config_id for Full and fast scan type
    get_scan_config_id();

    # Get target id of target to scan
    get_target_id();

    #Uncomment to debug
    print "\$openvas_user = $openvas_user\n";
    print "\$openvas_pass = $openvas_pass\n";
    print "\$task_to_add = $task_to_add\n";
    print "\$task_comment = $task_comment\n";
    print "\$config_id = $config_id\n";
    print "\$target_id = $target_id\n";
    print "\$scan_config = $scan_config\n";

    # Build OpenVAS cmd
    @openvas_cmd = "omp -u $openvas_user -w $openvas_pass --xml=\"<create_task><name>$task_to_add</name><comment>$task_comment</comment><config id='$config_id'/><target id='$target_id'/></create_task>\"";

    # Enable for debugging
    print "\@openvas_cmd = @openvas_cmd\n";

    # End sub with a return
    return;

    # End sub create_task

}   

sub get_scan_config_id {

    # Remove new lines & white space
    chomp $scan_config;
    #$scan_config =~ s/^\s+//gmx;
    #$scan_config =~ s/\s+$//gmx;

    if ( $scan_config = 'Fullandfast' ) {

      print "OMG a match!!!\n";

      # Get config_id using omp
      $config_id = `omp -u $openvas_user -w $openvas_pass -g |grep 'Full and fast' |egrep -v 'ultimate'`;

      # Strip $config_id
      $config_id =~ s/\s+Full\sand\sfast//gmx;

      print "\$config_id = $config_id\n";

    } else {

      print "Don't recognize $scan_config as a valid scan config!\n";

    }

   # End sub get_scan_config_id
}

sub get_target_id {

   # Get config_id using omp
   $target_id = `omp -u $openvas_user -w $openvas_pass -T |grep $target_to_scan`;

   # Remove new lines & white space
   chomp $target_id;
   $target_id =~ s/^\s+//gmx;
   $target_id =~ s/\s+$//gmx;

   # Strip $config_id
   $target_id =~ s/\s+$target_to_scan//gmx;

   print "\$target_id = $target_id\n";

   # End sub get_target_id
}

