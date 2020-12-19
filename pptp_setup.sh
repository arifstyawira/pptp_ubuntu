echo "======================="
echo "Installing PPTP VPN Server..."
echo "======================="
apt install pptpd -y
echo "Setting VPN Server IP : localip 172.16.0.1"
if grep -q "localip 172.16.0.1" /etc/pptpd.conf; then
    echo "Already set."
else
    sed -i 's/localip/#localip/g' /etc/pptpd.conf
    echo "localip 172.16.0.1" >> /etc/pptpd.conf
fi
echo "Setting IP Range : remoteip 172.16.0.100-200"
if grep -q "remoteip 172.16.0.100-200" /etc/pptpd.conf; then
    echo "Already set."
else
    sed -i 's/remoteip/#remoteip/g' /etc/pptpd.conf
    echo "remoteip 172.16.0.100-200" >> /etc/pptpd.conf
fi
echo "Setting DNS : 1.1.1.1"
if grep -q "ms-dns 1.1.1.1" /etc/ppp/pptpd-options; then
    echo "Already set."
else
    sed -i 's/ms-dns 1.1.1.1/#ms-dns 1.1.1.1/g' /etc/ppp/pptpd-options
    echo "ms-dns 1.1.1.1" >> /etc/ppp/pptpd-options
fi
echo "Setting DNS : 8.8.8.8"
if grep -q "ms-dns 8.8.8.8" /etc/ppp/pptpd-options; then
    echo "Already set."
else
    sed -i 's/ms-dns 8.8.8.8/#ms-dns 8.8.8.8/g' /etc/ppp/pptpd-options
    echo "ms-dns 8.8.8.8" >> /etc/ppp/pptpd-options
fi
echo "Setting : net.ipv4.ip_forward=1"
if grep -q "net.ipv4.ip_forward=1" /etc/sysctl.conf; then
    echo "Already set."
else
    sed -i 's/net.ipv4.ip_forward=1/#net.ipv4.ip_forward=1/g' /etc/sysctl.conf
    echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
    sysctl -p
fi
echo "Modify \"/etc/ppp/chap-secrets\". Add your users to allow PPTP login."
echo "Example of what to append to the file :"
echo "client1  pptpd    password1   *"
echo "======================="
echo "Starting VPN Service..."
echo "======================="
systemctl enable pptpd
systemctl start pptpd
service pptpd start
service pptpd restart
echo "done!"
