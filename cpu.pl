#!/usr/bin/perl -w

#############################################################################
# Nom : cpu.pl 							  	    #
# But : Extrait des informations CPU et les place dans un fichier           #
# Syntaxe : ./cpu.pl <nombre de secondes entre mesures> <nombre de mesures> #
# Exemple : ./cpu.pl 5 5       					            #
# Date : 30/03/12						            #
# Version : 1.1							  	    #
#	1.0 : Creation						  	    #
#	1.1 : Reception des arguments				  	    #
# Auteur : Sylvain Ballaud (Xpress2People)			  	    #
# Notes : Tester sur Linux Debian 2.6.32.5                        	    #
#############################################################################

# Declaration de modules
use strict;
use warnings;
use CPU;

# Declration des variables
my $num_args = $#ARGV + 1;
my $inter;
my $nb_prises;
my $i;
my $date = `date '+%d%m%y_%H%M%S'`;
my $file = "cpu_${date}";
my $rep_cap = "repertoire_capture";

# Verification des arguments
if ($num_args != 2)
{
        print "./cpu.pl <nombre de secondes entre mesures> <nombre de mesures>";
        exit 1;
}

# Reception de l'argument definissant l'intervalle entre deux mesures
$inter = $ARGV[0];

# Reception de l'argument definissant le nombre de prises
$nb_prises = $ARGV[1];

# Instanciation de l'objet CPU
my $OBJ_CPU = CPU->new(-1,-1,-1,-1,-1,-1,-1,-1);

# Creation/Ouverture du fichier
open(FIC1,">$rep_cap/$file") || die ("Cannot open file !!!");
my $sortie = select(FIC1);

# Extraction metriques CPU
for ($i=1; $i<=$nb_prises; $i++)  
{
	# Extraction metriques CPU
	$OBJ_CPU->show_cpu_user();
	$OBJ_CPU->show_cpu_sys();
	$OBJ_CPU->show_cpu_idle();
	$OBJ_CPU->show_cpu_wait();
	$OBJ_CPU->show_cpu_inter();
	$OBJ_CPU->show_cpu_cs();
	$OBJ_CPU->show_cpu_run();
	$OBJ_CPU->show_cpu_sleep();

	# Ecriture dans le fichier
	print "$OBJ_CPU->{ATT_CPU_USER}";
	print "$OBJ_CPU->{ATT_CPU_SYS}";
	print "$OBJ_CPU->{ATT_CPU_IDLE}";
	print "$OBJ_CPU->{ATT_CPU_WAIT}";
	print "$OBJ_CPU->{ATT_CPU_INTER}";
	print "$OBJ_CPU->{ATT_CPU_CS}";
	print "$OBJ_CPU->{ATT_CPU_RUN}";
	print "$OBJ_CPU->{ATT_CPU_SLEEP}\n";
	
	# Intervalle entre deux mesures
	system("sleep $inter");
}

# Fermeture du fichier
select($sortie);
close(FIC1);

# Fin du script
exit 0
