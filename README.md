# Multi Region VPN Connection Using OpenVPN
Connecting multiple regions together via a vpn connection using OpenVPN.

You only need to run these commands on the left side of the VPN. This is the VPN you normally connect to that you want to be able to navigate to other regions.

```
sudo su
apt-get update
apt-get install strongswan git -y
cd /root
git clone https://github.com/andrewpuch/multi_region_vpn_connection.git
cp multi_region_vpn_connection/ipsec.sh /sbin
cp multi_region_vpn_connection/ipsec.secrets /etc
cp multi_region_vpn_connection/ipsec.conf /etc
chmod 744 /sbin/ipsec.sh
chmod 744 /etc/ipsec.secrets
chmod 744 /etc/ipsec.conf
```

Edit the files according to the tutorial.

```
service ipsec restart
ipsec status
```
