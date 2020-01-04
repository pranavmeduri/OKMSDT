 
#------------------------------------------------------------------------------
# Defining options
# ------------------------------------------------------------------------------
set val(chan) 		Channel/WirelessChannel                    ;# channel type
set val(ant) 		Antenna/OmniAntenna                        ;# antenna type
set val(prop) 		Propagation/TwoRayGround 		   ;# propagation model
set val(netif) 		Phy/WirelessPhy                            ;# network interface type
set val(ll) 		LL                                         ;# link layer type
set val(ifq) 		Queue/DropTail/PriQueue                    ;# interface queue type
set val(ifqlen) 	150                                         ;# max packet in ifq
set val(mac) 		Mac/802_11                                 ;# MAC type
set val(rp) 		AODV 					   ;# routing protocol
set val(nn) 		125 					   ;# node number
set val(end) 		40                                        ;# simulation time [s]
set val(sc)	       	SCEN-1000X1000-N$val(nn)
set val(cp)		conn-e$val(nn)
set val(throughput) 	25.1 					   ;# CBR rate (<= 5.4Mb/s)
set opt(energymodel)    EnergyModel		   	
set opt(rxpower) 	0.395		        ;# initial receiving power	 
set opt(txpower) 	0.660			;# initial sending power 
set opt(idlepower) 	0.035			;# initial idle power	
set opt(initialenergy)  5.0			;#initial energy in joules
set val(x)		1000
set val(y)		1000
set psize		512
set rate		250kb

#remove-all-packet-headers 
Mac/802_11 set CWMin_                 31
Mac/802_11 set CWMax_                 1023
Mac/802_11 set SlotTime_              0.000020                     ;# 20us
Mac/802_11 set SIFS_                  0.000010                     ;# 10us
Mac/802_11 set PreambleLength_        144                         ;# 144 bit
Mac/802_11 set ShortPreambleLength_   72                           ;# 72 bit
Mac/802_11 set PreambleDataRate_      1.0e6                        ;# 1Mbps
Mac/802_11 set PLCPHeaderLength_      48                           ;# 48 bits
Mac/802_11 set PLCPDataRate_          1.0e6                        ;# 1Mbps
Mac/802_11 set ShortPLCPDataRate_     2.0e6                        ;# 2Mbps
Mac/802_11 set RTSThreshold_          3000                         ;# bytes
Mac/802_11 set ShortRetryLimit_       7                            ;# retransmissions
Mac/802_11 set LongRetryLimit_        4                            ;# retransmissions
Mac/802_11 set newchipset_            false                        ;# use new chipset, allowing a more recent  packet to be correctly received in place of the first sensed packet
Mac/802_11 set dataRate_ 11Mb                                      ;# 802.11 data transmission rate
Mac/802_11 set basicRate_ 2Mb                                      ;# 802.11 basic transmission rate 
Mac/802_11 set aarf_ false                                         ;# 802.11 Auto Rate Fallback


# ------------------------------------------------------------------------------
# Channel model
# ------------------------------------------------------------------------------
Antenna/OmniAntenna set X_ 0
Antenna/OmniAntenna set Y_ 0
Antenna/OmniAntenna set Z_ 1.5
Antenna/OmniAntenna set Gt_ 1                              ;# transmitter antenna gain
Antenna/OmniAntenna set Gr_ 1                              ;# receiver antenna gain
Phy/WirelessPhy set L_ 1.0                                 ;# system loss factor (mostly 1.0)

Phy/WirelessPhy set CPThresh_ 10.0                         ;# capture threshold in Watt
Phy/WirelessPhy set CSThresh_ 1.559e-11                    ;# Carrier Sensing threshold
Phy/WirelessPhy set RXThresh_ 3.652e-10                    ;# receiver signal threshold
Phy/WirelessPhy set freq_ 2.4e9                            ;# channel frequency (Hz)
Phy/WirelessPhy set Pt_ 0.28                               ;# transmitter signal power (Watt)


# ------------------------------------------------------------------------------
# General definition
# ------------------------------------------------------------------------------
#Instantiate the simulator
set ns_ [new Simulator]

# ------------------------------------------------------------------------------
# Trace file definition
# ------------------------------------------------------------------------------

#Create trace object for ns, nam, monitor and Inspect
set nsTrc [open out.tr w]
$ns_ trace-all $nsTrc
set namTrc [open out.nam w] 
$ns_ namtrace-all-wireless $namTrc $val(x) $val(y)

proc finish {} {
	global ns_ nsTrc namTrc
	$ns_ flush-trace 
	close $nsTrc
	close $namTrc
#	exec nam nam.trc &
}

#Define topology
set topo [new Topography]
$topo load_flatgrid $val(x) $val(y)

#Create channel
set chan [new $val(chan)]

set prop [new $val(prop)]

$prop topography $topo

#Create God
set god_ [create-god $val(nn)]

#Global node setting
$ns_ node-config -adhocRouting $val(rp) \
	-llType $val(ll) \
	-macType $val(mac) \
	-ifqType $val(ifq) \
	-ifqLen $val(ifqlen) \
	-antType $val(ant) \
	-propInstance $prop \
	-phyType $val(netif) \
	-channel $chan \
	-topoInstance $topo \
        -energyModel $opt(energymodel) \
	-rxPower $opt(rxpower) \
	-txPower $opt(txpower) \
	-idlePower $opt(idlepower) \
	-initialEnergy $opt(initialenergy) \
	-agentTrace ON \
	-routerTrace ON \
	-macTrace OFF \
	-movementTrace OFF

# ------------------------------------------------------------------------------
# Nodes definition
# ------------------------------------------------------------------------------
#  Create the specified number of nodes [$val(n)] and "attach" them to the channel.
for {set i 0} {$i < $val(nn) } {incr i} {
	set node_($i) [$ns_ node] 
	$node_($i) random-motion 0        ;# disable random motion
}	

source "../scen/$val(sc)"
source "../scen/$val(cp)"

for {set i 0} {$i < $val(nn)} {incr i} { 
		$ns_ initial_node_pos $node_($i) 50
}


# ------------------------------------------------------------------------------
# Tracing
# ------------------------------------------------------------------------------

# printing simulation time
proc timeTrace { tracePause} {
	global ns_
   	set now [$ns_ now]
   	$ns_ at [expr $now + $tracePause] "timeTrace $tracePause"
   	puts "$now simulation seconds"
}

$ns_ at 10.0 "timeTrace 10.0"


# ------------------------------------------------------------------------------
# Starting & ending
# ------------------------------------------------------------------------------
for {set i 0} {$i < $val(nn) } {incr i} {
    	$ns_ at $val(end) "$node_($i) reset";
}

$ns_ at $val(end) "finish"
$ns_ at $val(end) "$ns_ halt"

$ns_ run
