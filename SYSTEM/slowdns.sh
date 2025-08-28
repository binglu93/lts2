#!/bin/bash
# Script  By Julak Bantur Channel 
# 2025 SLOWDNS
# ===============================================


#setting IPtables
iptables -I INPUT -p udp --dport 5300 -j ACCEPT
iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
iptables-save >/etc/iptables/rules.v4 >/dev/null 2>&1
iptables-save >/etc/iptables.up.rules >/dev/null 2>&1
netfilter-persistent save >/dev/null 2>&1
netfilter-persistent reload >/dev/null 2>&1
systemctl enable iptables >/dev/null 2>&1
systemctl start iptables >/dev/null 2>&1
systemctl restart iptables >/dev/null 2>&1

# updae -- install
apt update -y
apt install -y python3 python3-dnslib net-tools
apt install ncurses-utils -y
apt install dnsutils -y
apt install git -y
apt install curl -y
apt install wget -y
apt install ncurses-utils -y
apt install screen -y
apt install cron -y
apt install iptables -y
apt install -y git screen whois dropbear wget
apt install -y sudo gnutls-bin
apt install -y dos2unix debconf-utils
service cron reload
service cron restart

#tambahan port openssh
cd
echo "Port 2222" >> /etc/ssh/sshd_config
echo "Port 2269" >> /etc/ssh/sshd_config
sed -i 's/#AllowTcpForwarding yes/AllowTcpForwarding yes/g' /etc/ssh/sshd_config
service ssh restart
service sshd restart

GACOR=$(cat /etc/xray/dns)
#konfigurasi slowdns
rm -rf /etc/slowdns
mkdir -p /etc/slowdns
wget -O dnstt-server "https://github.com/binglu93/lts2/raw/main/SLOWDNS/dnstt-server" && chmod +x dnstt-server >/dev/null 2>&1
wget -O dnstt-client "https://github.com/binglu93/lts2/raw/main/SLOWDNS/dnstt-client" && chmod +x dnstt-client >/dev/null 2>&1
./dnstt-server -gen-key -privkey-file server.key -pubkey-file server.pub
chmod +x *
mv * /etc/slowdns
wget -O /etc/systemd/system/client.service "https://github.com/binglu93/lts2/raw/main/SLOWDNS/client" >/dev/null 2>&1
wget -O /etc/systemd/system/server.service "https://github.com/binglu93/lts2/raw/main/SLOWDNS/server" >/dev/null 2>&1
sed -i "s/xxxx/$GACOR/g" /etc/systemd/system/client.service 
sed -i "s/xxxx/$GACOR/g" /etc/systemd/system/server.service 

systemctl daemon-reload
systemctl restart client
systemctl restart server
