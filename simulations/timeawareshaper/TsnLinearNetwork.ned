//
// SPDX-License-Identifier: LGPL-3.0-or-later
//


package simu5g_tsn.simulations.timeawareshaper;

import inet.networklayer.ipv4.RoutingTableRecorder;
import inet.networks.base.TsnNetworkBase;
import inet.node.contract.IEthernetNetworkNode;
import inet.node.ethernet.Eth100M;
import inet.node.ethernet.Eth10G;
import inet.node.inet.Router;
import simu5g.common.binder.Binder;
import simu5g.common.carrierAggregation.CarrierAggregation;
import simu5g.nodes.NR.NRUe;
import simu5g.nodes.Upf;
import simu5g.nodes.backgroundCell.BackgroundCell;
import simu5g.world.radio.LteChannelControl;


network TsnLinearNetwork extends TsnNetworkBase
{
    parameters:
        *.eth[*].bitrate = default(100Mbps);
        *.ethIf.bitrate = default(100Mbps);
        //============
        int numUe = default(1);
        int numBgCells = default(0);

    submodules:
        client: <default("TsnDevice")> like IEthernetNetworkNode {
            @display("p=218,260");
        }
        router: Router {
            @display("p=387,117;i=device/smallrouter");
        }
        switchA: <default("TsnSwitch")> like IEthernetNetworkNode {
            @display("p=313,178");
        }
        channelControl: LteChannelControl {
            @display("p=312,367;is=s");
        }
        routingRecorder: RoutingTableRecorder {
            @display("p=312,417;is=s");
        }
        binder: Binder {
            @display("p=312,517;is=s");
        }
        carrierAggregation: CarrierAggregation {
            @display("p=312,600;is=s");
        }
        upf: Upf {
            @display("p=527.35,116.9125");
        }
        iUpf: Upf {
            @display("p=725,118");
        }
        gnb: gNodeBwithEth {
            @display("p=726.35,277.35626;is=vl");
        }
        bgCell[numBgCells]: BackgroundCell {
            @display("p=416,277;is=vl");
        }
        ue[numUe]: NRUe {
            @display("p=628.09375,411.68124");
        }

    connections:
        client.ethg++ <--> Eth100M <--> switchA.ethg++;
        switchA.ethg++ <--> Eth100M <--> gnb.eth;
        upf.pppg++ <--> Eth10G <--> iUpf.pppg++;
}

