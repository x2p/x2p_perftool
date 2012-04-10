#!/usr/bin/perl -w

#############################################################################
# Nom : mem.pl                                                              #
# But : Extrait des informations memoire et les place dans un fichier       #
# Syntaxe : ./mem.pl <nombre de secondes entre mesures> <nombre de mesures> #
# Exemple : ./mem.pl 5 5                                                    #
# Date : 03/04/12                                                           #
# Version : 1.1                                                             #
#       1.0 : Creation                                                      #
#       1.1 : Reception des arguments                                       #
# Auteur : Sylvain Ballaud (Xpress2People)                                  #
# Notes : Tester sur Linux Debian 6, Fedora 16, CentOS 5.8 et OpenSUSE 12 	#
#############################################################################

# Declaration de modules
use strict;
use warnings;
use MEM;

# Declration des variables
my $num_args = $#ARGV + 1;
my $inter;
my $nb_prises;
my $i;
my $date = `date '+%d%m%y_%H%M%S'`;
my $file = "mem_${date}";
my $rep_cap = "repertoire_capture";

# Verification des arguments
if ($num_args != 2)
{
        print "./mem.pl <nombre de secondes entre mesures> <nombre de mesures>";
        exit 1;
}

# Reception de l'argument definissant l'intervalle entre deux mesures
$inter = $ARGV[0];

# Reception de l'argument definissant le nombre de prises
$nb_prises = $ARGV[1];

# Instanciation de l'objet MEM
my $OBJ_MEM = MEM->new(-1,-1,-1,-1,-1,-1,-1,-1);

# Creation/Ouverture du fichier
open(FIC2,">$rep_cap/$file") || die ("Cannot open file !!!");
my $sortie = select(FIC2);

# Extraction metriques CPU
for ($i=1; $i<=$nb_prises; $i++)
{
	# Extraction metriques MEM
	$OBJ_MEM->show_mem_total();
	$OBJ_MEM->show_mem_use();
	$OBJ_MEM->show_mem_free();
	$OBJ_MEM->show_mem_shared();
	$OBJ_MEM->show_mem_buf();
	$OBJ_MEM->show_mem_cache();
	$OBJ_MEM->show_mem_usewobuf();
	$OBJ_MEM->show_mem_freewobuf();
	$OBJ_MEM->show_swap_total();
	$OBJ_MEM->show_swap_use();
	$OBJ_MEM->show_swap_free();

        # Ecriture dans le fichier
        print "$OBJ_MEM->{ATT_MEM_TOTAL}";
        print "$OBJ_MEM->{ATT_MEM_USE}";
        print "$OBJ_MEM->{ATT_MEM_FREE}";
        print "$OBJ_MEM->{ATT_MEM_SHARED}";
        print "$OBJ_MEM->{ATT_MEM_BUF}";
        print "$OBJ_MEM->{ATT_MEM_CACHE}";
        print "$OBJ_MEM->{ATT_MEM_USEWOBUF}";
        print "$OBJ_MEM->{ATT_MEM_FREEWOBUF}";
        print "$OBJ_MEM->{ATT_SWAP_TOTAL}";
        print "$OBJ_MEM->{ATT_SWAP_USE}";
        print "$OBJ_MEM->{ATT_SWAP_FREE}\n";

	# Intervalle entre deux mesures
        system("sleep $inter");
}

# Fermeture du fichier
select($sortie);
close(FIC2);

# Fin du script
exit 0

