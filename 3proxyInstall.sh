#!/bin/bash
USERNAME="hermajor"
PASS="hahashka130"

rm -f 3pro*

echo "nameserver 9.9.9.9" > /etc/resolv.conf
curl http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -o epel-release-latest-7.noarch.rpm
rpm -ivh epel-release-latest-7.noarch.rpm
yum -y install 3proxy bind-utils
IP=($(dig +short myip.opendns.com @resolver1.opendns.com))
#mkdir /etc/3proxy/

wget --no-check-certificate 'https://raw.githubusercontent.com/mazhigali/3proxycfg/master/3proxy.cfg'
cp 3proxy.cfg /etc/
#echo "$USERNAME:CL:$PASS" > /etc/3proxy/.proxyauth
#chmod 600 /etc/3proxy/.proxyauth
#echo "users $USERNAME:CL:$PASS" >> /etc/3proxy.cfg
#echo "allow $USERNAME" >> /etc/3proxy.cfg
echo "socks -n -a -p24530 -i$IP -e$IP" >> /etc/3proxy.cfg

echo "-A INPUT -p tcp -m tcp --dport 24530 -m state --state NEW -j ACCEPT" >> /etc/sysconfig/iptables
#systemctl restart iptables

systemctl restart 3proxy
systemctl enable 3proxy
echo "Finish proxyinstall on $IP"
