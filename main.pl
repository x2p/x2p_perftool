#!/usr/bin/perl -w

##############################################################################
# Nom : main.pl                                                              #
# But : Extrait des informations CPU et les place dans un fichier            #
# Syntaxe : ./main.pl <nombre de secondes entre mesures> <nombre de mesures> #
# Exemple : ./main.pl 5 5                                                    #
# Date : 05/04/12                                                            #
# Version : 1.2                                                              #
#       1.0 : Creation                                                       #
#       1.1 : Reception des arguments                                        #
#       1.2 : Modification de la commande de capture de la liste des disques #
# Auteur : Sylvain Ballaud (Xpress2People)                                   #
# Notes : Tester sur Linux Debian 2.6.32.5                                   #
##############################################################################

# Declaration de modules
use strict;

# Declration des varaibles
my $num_args = $#ARGV + 1;
my @tab_disques;
my @tab_if;
my $liste_disques;
my $liste_if;
my $inter;
my $nb_prises;
my $disk;
my $if;
my $rep_cap = "repertoire_capture";

# Verification des arguments
if ($num_args != 2)
{
	print "Usage : ./main.pl <nombre de secondes entre mesures> <nombre de mesures> \n";
	exit 1;
}

# Est ce que le repertoire qui contient les captures existe ?
if (! -d "$rep_cap" ) 
{
	system("mkdir $rep_cap");
}

# Reception de l'argument definissant l'intervalle entre deux mesures
$inter = $ARGV[0];

# Reception de l'argument definissant le nombre de prises
$nb_prises = $ARGV[1];

# Liste des disques
@tab_disques = `vmstat -d | grep [hs]d[a-z] | awk '{print \$1}'`;

# Liste des interfaces reseau
@tab_if = `ifconfig -s | grep -v Iface | awk '{print \$1}' | grep -v lo`;

# Mesure CPU
system("/usr/bin/perl cpu.pl $inter $nb_prises &");

# Mesure Memoire
system("/usr/bin/perl mem.pl $inter $nb_prises &");

# Mesure Disques
foreach $disk (@tab_disques)
{
	$disk =~ s/\n//gs;
	system("/usr/bin/perl disk.pl $inter $nb_prises $disk &");
}

# Mesure Reseau
foreach $if (@tab_if)
{
        $if =~ s/\n//gs;
        system("/usr/bin/perl net.pl $inter $nb_prises $if &");
}

# Fin du programme 
exit 0;


