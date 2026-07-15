#!/bin/bash

echo "Atualizando regras do Cloudflare no UFW..."

# Limpra regras antigas 
ufw --force reset

# Regras padrão seguras
ufw default deny incoming
ufw default allow outgoing

# SSH
ufw allow ssh

# Baixa IPs oficiais Clouflare
for ip in $(curl -s https://www.cloudflare.com/ips-v4); do
        ufw allow from $ip to any port 80 proto tcp
        ufw allow from $ip to any port 443 proto tcp
done

for ip in $(curl -s https://www.cloudflare.com/ips-v6); do
        ufw allow from $ip to any port 80 proto tcp
        ufw allow from $ip to any port 443 proto tcp
done

# Ativa firewall
ufw --force enable

echo "Clouflare UFW atualizando com sucesso!"