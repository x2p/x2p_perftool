###################################################################
# Nom : DISK.PM                                                   #
# But : Module permettant d'extraire des informations disque      #
# Date : 02/04/12                                                 #
# Version : 1.0                                                   #
#       1.0 : Creation                                            #
# Auteur : Sylvain Ballaud (Xpress2People)                        #
# Notes : Tester sur Linux Debian 2.6.32.5                        #
###################################################################

# Declaration des modules
package DISK;
use strict;

# Declaration du Constructeur
sub new
{
	my ($class,$disk_name,$disk_read,$disk_write,$disk_read_merged,$disk_write_merged,$disk_read_sec,$disk_write_sec,$disk_time_read, $disk_time_write,$disk_nb_io,$disk_time_io) = @_;
	my $this = {};
	bless($this, $class);
	$this->{ATT_DISK_NAME} = $disk_name;
	$this->{ATT_DISK_READ} = $disk_read;
	$this->{ATT_DISK_WRITE} = $disk_write;
	$this->{ATT_DISK_READ_MERGED} = $disk_read_merged;
	$this->{ATT_DISK_WRITE_MERGED} = $disk_write_merged;
	$this->{ATT_DISK_READ_SEC} = $disk_read_sec;
	$this->{ATT_DISK_WRITE_SEC} = $disk_write_sec;
	$this->{ATT_DISK_TIME_READ} = $disk_time_read;
	$this->{ATT_DISK_TIME_WRITE} = $disk_time_write;
	$this->{ATT_DISK_NB_IO} = $disk_nb_io;
	$this->{ATT_DISK_TIME_IO} = $disk_time_io;
	return $this;
}
1;

# Declaration des methodes
sub show_disk_read
{
	my ($this) = @_;
	$this->{ATT_DISK_READ} = `vmstat -d | grep $this->{ATT_DISK_NAME} | awk '{print \$2}'`;
}

sub show_disk_write
{
        my ($this) = @_;
        $this->{ATT_DISK_WRITE} = `vmstat -d | grep $this->{ATT_DISK_NAME} | awk '{print \$6}'`;
}

sub show_disk_read_merged
{
        my ($this) = @_;
        $this->{ATT_DISK_READ_MERGED} = `vmstat -d | grep $this->{ATT_DISK_NAME} | awk '{print \$3}'`;
}

sub show_disk_write_merged
{
        my ($this) = @_;
        $this->{ATT_DISK_WRITE_MERGED} = `vmstat -d | grep $this->{ATT_DISK_NAME} | awk '{print \$7}'`;
}

sub show_disk_read_sec
{
        my ($this) = @_;
        $this->{ATT_DISK_READ_SEC} = `vmstat -d | grep $this->{ATT_DISK_NAME} | awk '{print \$4}'`;
}

sub show_disk_write_sec
{
        my ($this) = @_;
        $this->{ATT_DISK_WRITE_SEC} = `vmstat -d | grep $this->{ATT_DISK_NAME} | awk '{print \$8}'`;
}

sub show_disk_time_read
{
        my ($this) = @_;
        $this->{ATT_DISK_TIME_READ} = `vmstat -d | grep $this->{ATT_DISK_NAME} | awk '{print \$5}'`;
}

sub show_disk_time_write
{
        my ($this) = @_;
        $this->{ATT_DISK_TIME_WRITE} = `vmstat -d | grep $this->{ATT_DISK_NAME} | awk '{print \$9}'`;
}

sub show_disk_nb_io
{
        my ($this) = @_;
        $this->{ATT_DISK_NB_IO} = `vmstat -d | grep $this->{ATT_DISK_NAME} | awk '{print \$10}'`;
}

sub show_disk_time_io
{
        my ($this) = @_;
        $this->{ATT_DISK_TIME_IO} = `vmstat -d | grep $this->{ATT_DISK_NAME} | awk '{print \$11}'`;
}



