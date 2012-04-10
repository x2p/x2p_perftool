#!/usr/bin/perl -w

##################################################################################################
# Nom : net.pl                                                              					 #
# But : Extrait des informations CPU et les place dans un fichier           					 #
# Syntaxe : ./net.pl <nombre de secondes entre mesures> <nombre de mesures> <nom de l'interface> #
# Exemple : ./net.pl 5 5 eth0                                                 		  		     #
# Date : 04/04/12                                                           				     #
# Version : 1.2                                                             				     #
#       1.0 : Creation                                                      				     #
#       1.1 : Reception des arguments                                       					 #
#		1.2 : Modification des methodes show_net_rx_oct et show_net_tx_oct						 #
# Auteur : Sylvain Ballaud (Xpress2People)                                  					 #
# Notes : Tester sur Linux Debian 6, Fedora 16, CentOS 5.8 et OpenSUSE 12 				     	 #
##################################################################################################

# Declaration de modules
use strict;
use warnings;
use NET;

# Declration des variables
my $num_args = $#ARGV + 1;
my $inter;
my $nb_prises;
my $i;
my $net_name;
my $rep_cap = "repertoire_capture";

# Verification des arguments
if ($num_args != 3)
{
        print "./net.pl <nombre de secondes entre mesures> <nombre de mesures> <nom de l'interface>";
        exit 1;
}

# Reception de l'argument definissant l'intervalle entre deux mesures
$inter = $ARGV[0];

# Reception de l'argument definissant le nombre de prises
$nb_prises = $ARGV[1];

# Reception de l'argument definissant le nom de l'interface
$net_name = $ARGV[2];

# Creation du nom du fichier
my $date = `date '+%d%m%y_%H%M%S'`;
my $file = "${net_name}_${date}";

# Instanciation de l'objet NET
my $OBJ_NET = NET->new($net_name,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1);

# Creation/Ouverture du fichier
open(FIC4,">$rep_cap/$file") || die ("Cannot open file !!!");
my $sortie = select(FIC4);

# Extraction metriques NET
for ($i=1; $i<=$nb_prises; $i++)
{
        # Extraction metriques NET
        $OBJ_NET->show_net_rx_ok();
        $OBJ_NET->show_net_rx_err();
        $OBJ_NET->show_net_rx_drp();
        $OBJ_NET->show_net_rx_ovr();
        $OBJ_NET->show_net_tx_ok();
        $OBJ_NET->show_net_tx_err();
        $OBJ_NET->show_net_tx_drp();
        $OBJ_NET->show_net_tx_ovr();
        $OBJ_NET->show_net_frame();
        $OBJ_NET->show_net_carrier();
        $OBJ_NET->show_net_coll();
        $OBJ_NET->show_net_rx_oct();
        $OBJ_NET->show_net_tx_oct();

        # Ecriture dans le fichier
        print "$OBJ_NET->{ATT_NET_RX_OK}";
        print "$OBJ_NET->{ATT_NET_RX_ERR}";
        print "$OBJ_NET->{ATT_NET_RX_DRP}";
        print "$OBJ_NET->{ATT_NET_RX_OVR}";
        print "$OBJ_NET->{ATT_NET_TX_OK}";
        print "$OBJ_NET->{ATT_NET_TX_ERR}";
        print "$OBJ_NET->{ATT_NET_TX_DRP}";
        print "$OBJ_NET->{ATT_NET_TX_OVR}";
        print "$OBJ_NET->{ATT_NET_FRAME}";
        print "$OBJ_NET->{ATT_NET_CARRIER}";
        print "$OBJ_NET->{ATT_NET_COLL}";
        print "$OBJ_NET->{ATT_NET_RX_OCT}";
        print "$OBJ_NET->{ATT_NET_TX_OCT}\n";

        # Intervalle entre deux mesures
        system("sleep $inter");
}

# Fermeture du fichier
select($sortie);
close(FIC4);

# Fin du script
exit 0

