# Multi Region VPN Connection Using OpenVPN
Connecting multiple regions together via a vpn connection using OpenVPN.

```
apt-get update
apt-get install openswan git -y
cd /root
git clone https://github.com/andrewpuch/multi_region_vpn_connection.git
cp multi_region_vpn_connection/ipsec.sh /sbin
cp multi_region_vpn_connection/ipsec.secrets /etc
cp multi_region_vpn_connection/ipsec.conf /etc
```
