# Permitir ICMPv6 de qualquer local
ip6tables -A INPUT -p ipv6-icmp -j ACCEPT 

# Permitir qualquer coisa no loopback
ip6tables -A INPUT -i lo -j ACCEPT 

# Permitir Statefull
ip6tables -A INPUT -i tun -m state --state RELATED,ESTABLISHED -j ACCEPT 

# Filtrar todos os pacotes que tem cabeçalhos RH0
ip6tables -A INPUT -m rt --rt-type 0 -j DROP 

# Permitir enderecos Link-Local
ip6tables -A INPUT -s fe80::/10 -j ACCEPT 

# Permitir multicast
ip6tables -A INPUT -d ff00::/8 -j ACCEPT 

# Permitir ICMPv6 de qualquer local
ip6tables -A FORWARD -p ipv6-icmp -j ACCEPT 

# Filtrar todos os pacotes que tem cabeçalhos RH0
ip6tables -A FORWARD -m rt --rt-type 0 -j DROP 

# Permitir Statefull
ip6tables -A FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT 

# Permitir SSH e Ajenti
ip6tables -A INPUT -i eth0 -p tcp -m tcp --dport 22  -j ACCEPT 
ip6tables -A INPUT -i eth0 -p tcp -m tcp --dport 8549 -j ACCEPT
ip6tables -A INPUT -i eth0 -p tcp -m tcp --dport 8000 -j ACCEPT

#Apache e Redmine
ip6tables -A INPUT -i eth0 -p tcp -m tcp --dport 443 -j ACCEPT 
ip6tables -A INPUT -i eth0 -p tcp -m tcp --dport 3001 -j ACCEPT
ip6tables -A INPUT -i eth0 -p tcp -m tcp --dport 8080 -j ACCEPT
ip6tables -A INPUT -i eth0 -p tcp -m tcp --dport 8443 -j ACCEPT
ip6tables -A INPUT -i eth0 -p tcp -m tcp --dport 8090 -j ACCEPT


#Jabber
ip6tables -A INPUT -i eth0 -p tcp -m tcp --dport 5222 -j ACCEPT

#Nagios - NRPE
ip6tables -A INPUT -i eth0 -p tcp -m tcp --dport 5666 -j ACCEPT




# Permitir ICMPv6 de qualquer local
ip6tables -A OUTPUT -p ipv6-icmp -j ACCEPT 

# Permitir qualquer coisa no loopback
ip6tables -A OUTPUT -o lo -j ACCEPT 

# Permitindo qualquer saida para a Internet
ip6tables -A OUTPUT -o tun -j ACCEPT 

# Filtrar todos os pacotes que tem cabeçalhos RH0
ip6tables -A OUTPUT -m rt --rt-type 0 -j DROP 

# Permitir enderecos Link-Local
ip6tables -A OUTPUT -s fe80::/10 -j ACCEPT 

# Permitir multicast
ip6tables -A OUTPUT -d ff00::/8 -j ACCEPT 

# Permitindo qualquer saida
ip6tables -A OUTPUT -o eth0 -j ACCEPT