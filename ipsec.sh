#!/bin/bash
# OpenVPN Access Server Appliance AWS VPC VPN Strongswan updown Script

if [[ $PLUTO_VERB == "up-client" ]]; then
		if [[ $PLUTO_CONNECTION == "VPC-CUST-GW1" ]]; then
				iptables -t mangle -I PREROUTING -s $PLUTO_PEER -p esp -j MARK --set-mark 0xfffe
				ip xfrm policy add dir in src $PLUTO_PEER_CLIENT dst 0.0.0.0/0 proto any tmpl src $PLUTO_PEER dst $PLUTO_ME proto esp mode tunnel reqid $PLUTO_REQID level required priority 1500 mark 0xfffe
				ip xfrm policy add dir fwd src $PLUTO_PEER_CLIENT dst 0.0.0.0/0 proto any tmpl src $PLUTO_PEER dst $PLUTO_ME proto esp mode tunnel reqid $PLUTO_REQID level required priority 1500
				ip xfrm policy add dir out src 0.0.0.0/0 dst $PLUTO_PEER_CLIENT proto any tmpl src $PLUTO_ME dst $PLUTO_PEER proto esp mode tunnel reqid $PLUTO_REQID level required priority 1500
		fi
		if [[ $PLUTO_CONNECTION == "VPC-CUST-GW2" ]]; then
				iptables -t mangle -I PREROUTING -s $PLUTO_PEER -p esp -j MARK --set-mark 0xffff
				ip xfrm policy add dir in src $PLUTO_PEER_CLIENT dst 0.0.0.0/0 proto any tmpl src $PLUTO_PEER dst $PLUTO_ME proto esp mode tunnel reqid $PLUTO_REQID level required priority 1500 mark 0xffff
				ip xfrm policy add dir fwd src $PLUTO_PEER_CLIENT dst 0.0.0.0/1 proto any tmpl src $PLUTO_PEER dst $PLUTO_ME proto esp mode tunnel reqid $PLUTO_REQID level required priority 1500
				ip xfrm policy add dir out src 0.0.0.0/1 dst $PLUTO_PEER_CLIENT proto any tmpl src $PLUTO_ME dst $PLUTO_PEER proto esp mode tunnel reqid $PLUTO_REQID level required priority 1500
				ip xfrm policy add dir fwd src $PLUTO_PEER_CLIENT dst 128.0.0.0/1 proto any tmpl src $PLUTO_PEER dst $PLUTO_ME proto esp mode tunnel reqid $PLUTO_REQID level required priority 1500
				ip xfrm policy add dir out src 128.0.0.0/1 dst $PLUTO_PEER_CLIENT proto any tmpl src $PLUTO_ME dst $PLUTO_PEER proto esp mode tunnel reqid $PLUTO_REQID level required priority 1500
		fi
elif [[ $PLUTO_VERB == "down-client" ]]; then
		if [[ $PLUTO_CONNECTION == "VPC-CUST-GW1" ]]; then
				iptables -t mangle -D PREROUTING -s $PLUTO_PEER -p esp -j MARK --set-mark 0xfffe
				ip xfrm policy del dir in src $PLUTO_PEER_CLIENT dst 0.0.0.0/0 mark 0xfffe
				ip xfrm policy del dir fwd src $PLUTO_PEER_CLIENT dst 0.0.0.0/0
				ip xfrm policy del dir out src 0.0.0.0/0 dst $PLUTO_PEER_CLIENT
		fi
		if [[ $PLUTO_CONNECTION == "VPC-CUST-GW2" ]]; then
				iptables -t mangle -D PREROUTING -s $PLUTO_PEER -p esp -j MARK --set-mark 0xffff
				ip xfrm policy del dir in src $PLUTO_PEER_CLIENT dst 0.0.0.0/0 mark 0xffff
				ip xfrm policy del dir fwd src $PLUTO_PEER_CLIENT dst 0.0.0.0/1
				ip xfrm policy del dir out src 0.0.0.0/1 dst $PLUTO_PEER_CLIENT
				ip xfrm policy del dir fwd src $PLUTO_PEER_CLIENT dst 128.0.0.0/1
				ip xfrm policy del dir out src 128.0.0.0/1 dst $PLUTO_PEER_CLIENT
		fi
fi
