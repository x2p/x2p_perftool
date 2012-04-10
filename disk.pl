#!/usr/bin/perl -w

##############################################################################################
# Nom : disk.pl      	                                                     		   	     #
# But : Extrait des informations disque et les place dans un fichier 	     		   	     #
# Syntaxe : ./disk.pl <nombre de secondes entre mesures> <nombre de mesures> <nom du disque> #
# Exemple : ./disk.pl 10 3 sda                                                   		     #
# Date : 02/04/12              		                                     		    		 #
# Version : 1.1                           	                             		  		     #
#       1.0 : Creation                               		             		   		     #
#       1.1 : Reception des arguments                           	     		   		     #
# Auteur : Sylvain Ballaud (Xpress2People)                       	     		   			 #
# Notes : Tester sur Linux Debian 6, Fedora 16, CentOS 5.8 et OpenSUSE 12 					 #
##############################################################################################

# Declaration des modules
use strict;
use warnings;
use DISK;

# Declration des variables
my $num_args = $#ARGV + 1;
my $inter;
my $nb_prises;
my $i;
my $disk_name;
my $rep_cap = "repertoire_capture";

# Verification des arguments
if ($num_args != 3)
{
        print "./disk.pl <nombre de secondes entre mesures> <nombre de mesures> <nom du disque>";
        exit 1;
}

# Reception de l'argument definissant l'intervalle entre deux mesures
$inter = $ARGV[0];

# Reception de l'argument definissant le nombre de prises
$nb_prises = $ARGV[1];

# Reception de l'argument definissant le nom du disque
$disk_name = $ARGV[2];

# Creation du nom du fichier
my $date = `date '+%d%m%y_%H%M%S'`;
my $file = "${disk_name}_${date}";

# Instanciation de l'objet DISK
my $OBJ_DISK = DISK->new($disk_name,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1);

# Creation/Ouverture du fichier
open(FIC3,">$rep_cap/$file") || die ("Cannot open file !!!");
my $sortie = select(FIC3);

# Extraction metriques DISK
for ($i=1; $i<=$nb_prises; $i++)
{
        # Extraction metriques DISK
        $OBJ_DISK->show_disk_read();
        $OBJ_DISK->show_disk_write();
        $OBJ_DISK->show_disk_read_merged();
        $OBJ_DISK->show_disk_write_merged();
        $OBJ_DISK->show_disk_read_sec();
        $OBJ_DISK->show_disk_write_sec();
	$OBJ_DISK->show_disk_time_read();
	$OBJ_DISK->show_disk_time_write();
	$OBJ_DISK->show_disk_nb_io();
	$OBJ_DISK->show_disk_time_io();

        # Ecriture dans le fichier
        print "$OBJ_DISK->{ATT_DISK_READ}";
        print "$OBJ_DISK->{ATT_DISK_WRITE}";
        print "$OBJ_DISK->{ATT_DISK_READ_MERGED}";
        print "$OBJ_DISK->{ATT_DISK_WRITE_MERGED}";
        print "$OBJ_DISK->{ATT_DISK_READ_SEC}";
        print "$OBJ_DISK->{ATT_DISK_WRITE_SEC}";
        print "$OBJ_DISK->{ATT_DISK_TIME_READ}";
        print "$OBJ_DISK->{ATT_DISK_TIME_WRITE}";
        print "$OBJ_DISK->{ATT_DISK_NB_IO}";
        print "$OBJ_DISK->{ATT_DISK_TIME_IO}\n";

        # Intervalle entre deux mesures
        system("sleep $inter");
}

# Fermeture du fichier
select($sortie);
close(FIC3);

# Fin du script
exit 0

