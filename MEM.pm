###########################################################################
# Nom : MEM.PM                                                    		  #
# But : Module permettant d'extraire des informations CPU         		  #
# Date : 03/04/12                                                 		  #
# Version : 1.0                                                   		  #
#       1.0 : Creation                                            		  #
# Auteur : Sylvain Ballaud (Xpress2People)                        		  #
# Notes : Tester sur Linux Debian 6, Fedora 16, CentOS 5.8 et OpenSUSE 12 #
###########################################################################

# Declaration des modules
package MEM;
use strict;

# Declaration du constructeur
sub new
{
	my ($class,$mem_total,$mem_use,$mem_free,$mem_shared,$mem_buf,$mem_cache,$mem_usewobuf,$mem_freewobuf,$swap_total,$swap_use,$swap_free) = @_;
	my $this = {};
	bless($this, $class);
	$this->{ATT_MEM_TOTAL} = $mem_total;
	$this->{ATT_MEM_USE} = $mem_use;
	$this->{ATT_MEM_FREE} = $mem_free;
	$this->{ATT_MEM_SHARED} = $mem_shared;
        $this->{ATT_MEM_BUF} = $mem_buf;
        $this->{ATT_MEM_CACHE} = $mem_cache;
	$this->{ATT_MEM_USEWOBUF} = $mem_usewobuf;
        $this->{ATT_MEM_FREEWOBUF} = $mem_freewobuf;

	$this->{ATT_SWAP_TOTAL} = $swap_total;
        $this->{ATT_SWAP_USE} = $swap_use;
        $this->{ATT_SWAP_FREE} = $swap_free;

	return $this;
}
1;

# Declaration des methodes
sub show_mem_total
{
	my ($this) = @_;
	$this->{ATT_MEM_TOTAL} = `free -m | grep Mem: | awk '{print \$2}'`;
}

sub show_mem_use
{
        my ($this) = @_;
        $this->{ATT_MEM_USE} = `free -m | grep Mem: | awk '{print \$3}'`;
}

sub show_mem_free
{
        my ($this) = @_;
        $this->{ATT_MEM_FREE} = `free -m | grep Mem: | awk '{print \$4}'`;
}

sub show_mem_shared
{
        my ($this) = @_;
        $this->{ATT_MEM_SHARED} = `free -m | grep Mem: | awk '{print \$5}'`;
}

sub show_mem_buf
{
        my ($this) = @_;
        $this->{ATT_MEM_BUF} = `free -m | grep Mem: | awk '{print \$6}'`;
}

sub show_mem_cache
{
        my ($this) = @_;
        $this->{ATT_MEM_CACHE} = `free -m | grep Mem: | awk '{print \$7}'`;
}

sub show_mem_usewobuf
{
        my ($this) = @_;
        $this->{ATT_MEM_USEWOBUF} = `free -m | grep buffers/cache: | awk '{print \$3}'`;
}

sub show_mem_freewobuf
{
        my ($this) = @_;
        $this->{ATT_MEM_FREEWOBUF} = `free -m | grep buffers/cache: | awk '{print \$4}'`;
}


sub show_swap_total
{
        my ($this) = @_;
        $this->{ATT_SWAP_TOTAL} = `free -m | grep Swap: | awk '{print \$2}'`;
}

sub show_swap_use
{
        my ($this) = @_;
        $this->{ATT_SWAP_USE} = `free -m | grep Swap: | awk '{print \$3}'`;
}

sub show_swap_free
{
        my ($this) = @_;
        $this->{ATT_SWAP_FREE} = `free -m | grep Swap: | awk '{print \$4}'`;
}

