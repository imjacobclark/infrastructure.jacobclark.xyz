/sbin/iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
/sbin/iptables -A INPUT -i lo -j ACCEPT
# Switch on for debugging
# /sbin/iptables -A INPUT -p tcp --dport 22 -j ACCEPT
/sbin/iptables -A INPUT -p tcp --dport 80 -j ACCEPT
/sbin/iptables -A INPUT -p tcp --dport 443 -j ACCEPT

/sbin/iptables -P INPUT -j DROP
/sbin/iptables -P FORWARD -j REJECT
/sbin/iptables -P OUTPUT -j ACCEPT
