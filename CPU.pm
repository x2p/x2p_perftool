###########################################################################
# Nom : CPU.PM                                              		      #
# But : Module permettant d'extraire des informations CPU				  #
# Date : 30/03/12                                           		      #
# Version : 1.0                                              		      #
#       1.0 : Creation                                         		      #
# Auteur : Sylvain Ballaud (Xpress2People)                       		  #
# Notes : Tester sur Linux Debian 6, Fedora 16, CentOS 5.8 et OpenSUSE 12 #
###########################################################################

# Declaration des modules
package CPU;
use strict;

# Declaration du constructeur
sub new
{
	my ($class,$cpu_user,$cpu_sys,$cpu_idle,$cpu_wait,$cpu_inter,$cpu_cs,$cpu_run,$cpu_sleep) = @_;
	my $this = {};
	bless($this, $class);
	$this->{ATT_CPU_USER} = $cpu_user;
	$this->{ATT_CPU_SYS} = $cpu_sys;
	$this->{ATT_CPU_IDLE} = $cpu_idle;
	$this->{ATT_CPU_WAIT} = $cpu_wait;
	$this->{ATT_CPU_INT} = $cpu_inter;
	$this->{ATT_CPU_CS} = $cpu_cs;
	$this->{ATT_CPU_RUN} = $cpu_run;
	$this->{ATT_CPU_SLEEP} = $cpu_sleep;
	return $this;
}
1;

# Declaration des methodes
sub show_cpu_user
{
	my ($this) = @_;
	$this->{ATT_CPU_USER} = `vmstat | tail -n 1 | awk '{print \$13}'`;
}

sub show_cpu_sys
{
        my ($this) = @_;
        $this->{ATT_CPU_SYS} = `vmstat | tail -n 1 | awk '{print \$14}'`;
}

sub show_cpu_idle
{
        my ($this) = @_;
        $this->{ATT_CPU_IDLE} = `vmstat | tail -n 1 | awk '{print \$15}'`;
}

sub show_cpu_wait
{
        my ($this) = @_;
        $this->{ATT_CPU_WAIT} = `vmstat | tail -n 1 | awk '{print \$16}'`;
}

sub show_cpu_inter
{
        my ($this) = @_;
        $this->{ATT_CPU_INTER} = `vmstat | tail -n 1 | awk '{print \$11}'`;
}

sub show_cpu_cs
{
        my ($this) = @_;
        $this->{ATT_CPU_CS} = `vmstat | tail -n 1 | awk '{print \$12}'`;
}

sub show_cpu_run
{
        my ($this) = @_;
        $this->{ATT_CPU_RUN} = `vmstat | tail -n 1 | awk '{print \$1}'`;
}

sub show_cpu_sleep
{
        my ($this) = @_;
        $this->{ATT_CPU_SLEEP} = `vmstat | tail -n 1 | awk '{print \$2}'`;
}



