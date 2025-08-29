#!/bin/bash
REPO="https://raw.githubusercontent.com/binglu93/lts2/main/"

wget -q -O /etc/systemd/system/limitvmess.service "${REPO}TOOLS/limitvmess.service" && chmod +x limitvmess.service >/dev/null 2>&1
wget -q -O /etc/systemd/system/limitvless.service "${REPO}TOOLS/limitvless.service" && chmod +x limitvless.service >/dev/null 2>&1
wget -q -O /etc/systemd/system/limittrojan.service "${REPO}TOOLS/limittrojan.service" && chmod +x limittrojan.service >/dev/null 2>&1
wget -q -O /etc/systemd/system/limitshadowsocks.service "${REPO}TOOLS/limitshadowsocks.service" && chmod +x limitshadowsocks.service >/dev/null 2>&1
wget -q -O /etc/xray/limit.vmess "${REPO}TOOLS/vmess" >/dev/null 2>&1
wget -q -O /etc/xray/limit.vless "${REPO}TOOLS/vless" >/dev/null 2>&1
wget -q -O /etc/xray/limit.trojan "${REPO}TOOLS/trojan" >/dev/null 2>&1
wget -q -O /etc/xray/limit.shadowsocks "${REPO}TOOLS/shadowsocks" >/dev/null 2>&1
chmod +x /etc/xray/limit.vmess
chmod +x /etc/xray/limit.vless
chmod +x /etc/xray/limit.trojan
chmod +x /etc/xray/limit.shadowsocks
systemctl daemon-reload
systemctl enable --now limitvmess
systemctl enable --now limitvless
systemctl enable --now limittrojan
systemctl enable --now limitshadowsocks

cd
wget -q -O /usr/bin/limit-ip "https://raw.githubusercontent.com/binglu93/lts2/main/TOOLS/limit-ip"
chmod +x /usr/bin/*
cd /usr/bin
sed -i 's/\r//' limit-ip
clear
wget -q -O /usr/bin/limit-ip-ssh "https://raw.githubusercontent.com/binglu93/lts2/main/TOOLS/limit-ip-ssh"
chmod +x /usr/bin/*
cd /usr/bin
sed -i 's/\r//' limit-ip-ssh
clear
#SERVICE LIMIT ALL IP
cat >/etc/systemd/system/sship.service << EOF
[Unit]
Description=My
After=network.target

[Service]
ExecStart=/usr/bin/limit-ip-ssh sship
Restart=always
RestartSec=3
StartLimitIntervalSec=60
StartLimitBurst=5

[Install]
WantedBy=default.target
EOF
systemctl daemon-reload
systemctl restart sship
systemctl enable sship
#SERVICE LIMIT ALL IP
cat >/etc/systemd/system/vmip.service << EOF
[Unit]
Description=My
ProjectAfter=network.target

[Service]
WorkingDirectory=/root
ExecStart=/usr/bin/limit-ip vmip
Restart=always

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl restart vmip
systemctl enable vmip

cat >/etc/systemd/system/vlip.service << EOF
[Unit]
Description=My
ProjectAfter=network.target

[Service]
WorkingDirectory=/root
ExecStart=/usr/bin/limit-ip vlip
Restart=always

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl restart vlip
systemctl enable vlip

cat >/etc/systemd/system/trip.service << EOF
[Unit]
Description=My
ProjectAfter=network.target

[Service]
WorkingDirectory=/root
ExecStart=/usr/bin/limit-ip trip
Restart=always

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl restart trip
systemctl enable trip

rm -rf /root/limit.sh
