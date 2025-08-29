#!/bin/bash
user="$3"
timer="$4"
function trialssh() {
    while true; do
        sleep ${timer}m
        getent passwd $user  >/dev/null
        userdel -f $user  >/dev/null 2>&1
        systemctl restart sshd >/dev/null 2>&1
        exp=$(grep -wE "^### $user" "/etc/xray/ssh" | cut -d ' ' -f 3 | sort | uniq)
        pass=$(grep -wE "^### $user" "/etc/xray/ssh" | cut -d ' ' -f 4 | sort | uniq)
        sed -i "s/### $user $exp $pass//g" /etc/xray/ssh >/dev/null 2>&1 
        rm -rf /home/vps/public_html/ssh-$user.txt >/dev/null 2>&1
        rm -rf /etc/xray/sshx/${user}IP >/dev/null 2>&1
        rm -rf /etc/xray/sshx/${user}login >/dev/null 2>&1
        rm -rf /etc/xray/sshx/akun/log-create-${user}.log >/dev/null 2>&1
        rm -rf /etc/cron.d/trialssh${user} >/dev/null 2>&1
        break
    done
}
function trialws() {
    while true; do
        sleep ${timer}m
        exp=$(grep -wE "^#vm $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
        sed -i "/^#vm $user $exp/,/^},{/d" /etc/xray/config.json >/dev/null 2>&1
        sed -i "/^#vmg $user $exp/,/^},{/d" /etc/xray/config.json >/dev/null 2>&1
        rm -rf /home/vps/public_html/vmess-$user.txt >/dev/null 2>&1
        rm -rf /etc/vmess/${user}IP >/dev/null 2>&1
        rm -rf /etc/vmess/${user}login >/dev/null 2>&1
        rm -rf /etc/vmess/${user} >/dev/null 2>&1
        rm -rf /etc/vmess/akun/log-create-${user}.log >/dev/null 2>&1
        rm -rf /etc/cron.d/trialvmess${user} >/dev/null 2>&1
        systemctl restart xray >/dev/null 2>&1
        break
    done
}
function trialvl() {
    while true; do
        sleep ${timer}m
        exp=$(grep -wE "^#vl $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
        sed -i "/^#vl $user $exp/,/^},{/d" /etc/xray/config.json >/dev/null 2>&1
        sed -i "/^#vlg $user $exp/,/^},{/d" /etc/xray/config.json >/dev/null 2>&1
        rm -rf /home/vps/public_html/vless-$user.txt >/dev/null 2>&1
        rm -rf /etc/vless/${user}IP >/dev/null 2>&1
        rm -rf/etc/vless/${user}login >/dev/null 2>&1
        rm -rf /etc/vless/${user} >/dev/null 2>&1
        rm -rf /etc/vless/akun/log-create-${user}.log >/dev/null 2>&1
        rm -rf /etc/cron.d/trialvless${user} >/dev/null 2>&1
        systemctl restart xray >/dev/null 2>&1
        break
    done
}
function trialtr() {
    while true; do
        sleep ${timer}m
        exp=$(grep -wE "^#tr $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
        sed -i "/^#tr $user $exp/,/^},{/d" /etc/xray/config.json >/dev/null 2>&1
        sed -i "/^#trg $user $exp/,/^},{/d" /etc/xray/config.json >/dev/null 2>&1
        rm -rf /home/vps/public_html/trojan-$user.txt >/dev/null 2>&1
        rm -rf /etc/trojan/${user}IP >/dev/null 2>&1
        rm -rf /etc/trojan/${user}login >/dev/null 2>&1
        rm -rf /etc/trojan/${user} >/dev/null 2>&1
        rm -rf /etc/trojan/akun/log-create-${user}.log >/dev/null 2>&1
        rm -rf /etc/cron.d/trialtrojan${user} >/dev/null 2>&1
        systemctl restart xray >/dev/null 2>&1
        break
    done
}
function trialss() {
    while true; do
        sleep ${timer}m
        exp=$(grep -wE "^#ss $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
        sed -i "/^#ss $user $exp/,/^},{/d" /etc/xray/config.json >/dev/null 2>&1
        sed -i "/^#ssg $user $exp/,/^},{/d" /etc/xray/config.json >/dev/null 2>&1
        systemctl restart xray >/dev/null 2>&1
        break
    done
}
if [[ ${2} == "vmess" ]]; then
    vmess
elif [[ ${2} == "vless" ]]; then
    vless
elif [[ ${2} == "trojan" ]]; then
    trojan
elif [[ ${2} == "trialss" ]]; then
    trialss
elif [[ ${2} == "ssh" ]]; then
    ssh
fi
