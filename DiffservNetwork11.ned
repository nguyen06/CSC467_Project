//
// Copyright (C) 2012 Opensim Ltd.
// Author: Tamas Borbely
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
//

package inet.examples.diffserv.onedomain;

import inet.common.misc.ThruputMeteringChannel;
import inet.examples.inet.ipv4hook.MyRouter;
import inet.networklayer.configurator.ipv4.IPv4NetworkConfigurator;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;


network DiffservNetwork11
{
    parameters:
        double edgeDatarate @unit(bps);
        double coreDatarate @unit(bps);
    types:
        channel edgeline extends ThruputMeteringChannel
        {
            delay = 2ms;
            datarate = edgeDatarate;
            thruputDisplayFormat = "b B U";
        }
        channel coreline extends ThruputMeteringChannel
        {
            delay = 2ms;
            datarate = coreDatarate;
            thruputDisplayFormat = "b B U";
        }
        channel ethernetline extends ThruputMeteringChannel
        {
            delay = 0.1us;
            datarate = 100Mbps;
            thruputDisplayFormat = "b B U";
        }
    submodules:
        R4: Router {
            @display("p=546,309");
        }
        R2: Router {
            @display("p=235,303");
        }
        R1: Router {
            @display("p=107,303");
        }
        R3: Router {
            @display("p=447,303");
        }

        H1: StandardHost {
            @display("p=34,235");
        }
        H2: StandardHost {
            @display("p=34,323");
        }
        configurator: IPv4NetworkConfigurator {
            @display("p=76,134");
        }
        H3: StandardHost {
            @display("p=43,385");
        }
        H7: StandardHost {
            @display("p=459,235");
        }
        H9: StandardHost {
            @display("p=487,355");
        }
        H8: StandardHost {
            @display("p=522,247");
        }
        H4: StandardHost {
            @display("p=196,221");
        }
        H5: StandardHost {
            @display("p=157,247");
        }
        H6: StandardHost {
            @display("p=157,344");
        }
        H10: StandardHost {
            @display("p=561,385");
        }
        R11: Router {
            @display("p=379,303");
        }
        R10: Router {
            @display("p=302,303");
        }
        H12: StandardHost {
            @display("p=654,268");
        }
        H11: StandardHost {
            @display("p=654,338");
        }
    connections:
        H1.ethg++ <--> ethernetline <--> R1.ethg++;
        H2.ethg++ <--> ethernetline <--> R1.ethg++;
        H3.ethg++ <--> ethernetline <--> R1.ethg++;
        R3.ethg++ <--> ethernetline <--> H7.ethg++;
        R3.ethg++ <--> ethernetline <--> H8.ethg++;
        R3.ethg++ <--> ethernetline <--> H9.ethg++;
        R2.ethg++ <--> ethernetline <--> H4.ethg++;
        R2.ethg++ <--> ethernetline <--> H5.ethg++;
        H10.ethg++ <--> ethernetline <--> R4.ethg++;
        H12.ethg++ <--> ethernetline <--> R4.ethg++;
        H11.ethg++ <--> ethernetline <--> R4.ethg++;
        R1.pppg++ <--> edgeline <--> R2.pppg++;
        R4.pppg++ <--> edgeline <--> R3.pppg++;
        R2.ethg++ <--> coreline <--> H6.ethg++;
        R2.pppg++ <--> edgeline <--> R10.pppg++;
        R11.pppg++ <--> edgeline <--> R3.pppg++;
        R10.pppg++ <--> coreline <-->R11.pppg++;
}

