#############################################################################
# Nom : NET.PM                                                   	    #
# But : Module permettant d'extraire des informations reseau                #
# Date : 04/04/12                                                           #
# Version : 1.1                                                             #
#       1.0 : Creation                                                      #
#	1.1 : Modification des fonctions show_net_rx_oct et show_net_tx_oct # 
# Auteur : Sylvain Ballaud (Xpress2People)                                  #
# Notes : Tester sur Linux Debian 2.6.32.5                                  #
#############################################################################

# Declaration des modules
package NET;
use strict;

# Declaration du constructeur
sub new
{
	my ($class,$net_name,$net_rx_ok,$net_rx_err,$net_rx_drp,$net_rx_ovr,$net_tx_ok,$net_tx_err,$net_tx_drp,$net_tx_ovr,$net_frame,$net_carrier,$net_coll,$net_rx_oct,$net_tx_oct) = @_;
	my $this = {};
	bless($this, $class);
	$this->{ATT_NET_NAME} = $net_name;
	$this->{ATT_NET_RX_OK} = $net_rx_ok;
	$this->{ATT_NET_RX_ERR} = $net_rx_err;
	$this->{ATT_NET_RX_DRP} = $net_rx_drp;
	$this->{ATT_NET_RX_OVR} = $net_rx_ovr;
	$this->{ATT_NET_TX_OK} = $net_tx_ok;
	$this->{ATT_NET_TX_ERR} = $net_tx_err;
	$this->{ATT_NET_TX_DRP} = $net_tx_drp;
	$this->{ATT_NET_TX_OVR} = $net_tx_ovr;
	$this->{ATT_NET_FRAME} = $net_frame;
	$this->{ATT_NET_CARRIER} = $net_carrier;
	$this->{ATT_NET_COLL} = $net_coll;
	$this->{ATT_NET_RX_OCT} = $net_rx_oct;
	$this->{ATT_NET_TX_OCT} = $net_tx_oct;
	return $this;
}
1;

# Declaration des methodes
sub show_net_rx_ok
{
	my ($this) = @_;
	$this->{ATT_NET_RX_OK} = `ifconfig $this->{ATT_NET_NAME} | grep "RX packets" | awk '{print \$2}' | awk -F':' '{print \$2}'`;
}

sub show_net_rx_err
{
        my ($this) = @_;
        $this->{ATT_NET_RX_ERR} = `ifconfig $this->{ATT_NET_NAME} | grep "RX packets" | awk '{print \$3}' | awk -F':' '{print \$2}'`;
}

sub show_net_rx_drp
{
        my ($this) = @_;
        $this->{ATT_NET_RX_DRP} = `ifconfig $this->{ATT_NET_NAME} | grep "RX packets" | awk '{print \$4}' | awk -F':' '{print \$2}'`;
}

sub show_net_rx_ovr
{
        my ($this) = @_;
        $this->{ATT_NET_RX_OVR} = `ifconfig $this->{ATT_NET_NAME} | grep "RX packets" | awk '{print \$5}' | awk -F':' '{print \$2}'`;
}

sub show_net_tx_ok
{
        my ($this) = @_;
        $this->{ATT_NET_TX_OK} = `ifconfig $this->{ATT_NET_NAME} | grep "TX packets" | awk '{print \$2}' | awk -F':' '{print \$2}'`;
}

sub show_net_tx_err
{
        my ($this) = @_;
        $this->{ATT_NET_TX_ERR} = `ifconfig $this->{ATT_NET_NAME} | grep "TX packets" | awk '{print \$3}' | awk -F':' '{print \$2}'`;
}

sub show_net_tx_drp
{
        my ($this) = @_;
        $this->{ATT_NET_TX_DRP} = `ifconfig $this->{ATT_NET_NAME} | grep "TX packets" | awk '{print \$4}' | awk -F':' '{print \$2}'`;
}

sub show_net_tx_ovr
{
        my ($this) = @_;
        $this->{ATT_NET_TX_OVR} = `ifconfig $this->{ATT_NET_NAME} | grep "TX packets" | awk '{print \$5}' | awk -F':' '{print \$2}'`;
}

sub show_net_frame
{
        my ($this) = @_;
        $this->{ATT_NET_FRAME} = `ifconfig $this->{ATT_NET_NAME} | grep "RX packets" | awk '{print \$6}' | awk -F':' '{print \$2}'`;
}

sub show_net_carrier
{
        my ($this) = @_;
        $this->{ATT_NET_CARRIER} = `ifconfig $this->{ATT_NET_NAME} | grep "TX packets" | awk '{print \$6}' | awk -F':' '{print \$2}'`;
}

sub show_net_coll
{
        my ($this) = @_;
        $this->{ATT_NET_COLL} = `ifconfig $this->{ATT_NET_NAME} | grep collisions | awk '{print \$1}' | awk -F':' '{print \$2}'`;
}

sub show_net_rx_oct
{
        my ($this) = @_;
        $this->{ATT_NET_RX_OCT} = `ifconfig $this->{ATT_NET_NAME} | grep "RX bytes" | awk '{print \$2}' | awk -F':' '{print \$2}'`;
}

sub show_net_tx_oct
{
        my ($this) = @_;
        $this->{ATT_NET_TX_OCT} = `ifconfig $this->{ATT_NET_NAME} | grep "RX bytes" | awk '{print \$6}' | awk -F':' '{print \$2}'`;
}

