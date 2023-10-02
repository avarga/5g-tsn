//
// SPDX-License-Identifier: LGPL-3.0-or-later
//


package simu5g_tsn.simulations.timeawareshaper3;

import inet.linklayer.ethernet.LayeredEthernetInterface;
import inet.linklayer.ethernet.modular.EthernetLayer;
import simu5g.nodes.NR.gNodeB;


module gNodeBwithEth extends gNodeB
{
    gates:
        inout eth @loose;
    types:
        channel Unnamed
        {
        }

    submodules:
        ethIf: LayeredEthernetInterface {
            @display("p=1151.8201,519.82");
        }
        ethernet: EthernetLayer {
            @display("p=1243.46,519.82");
        }
    connections:
        ethIf.phys <--> eth;
        ethIf.upperLayerOut --> ethernet.lowerLayerIn;
        ethIf.upperLayerIn <-- ethernet.lowerLayerOut;
        ethernet.upperLayerOut --> nl.in++;
        ethernet.upperLayerIn <-- nl.out++;
}
