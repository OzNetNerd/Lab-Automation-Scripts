#!/bin/bash

export PRIVATE_HOSTNAME=$(curl http://169.254.169.254/latest/meta-data/local-hostname)
export PUBLIC_HOSTNAME=$(curl http://169.254.169.254/latest/meta-data/public-hostname)

sudo sh -c "echo '127.0.0.1   $PUBLIC_HOSTNAME' >> /etc/hosts"
cd /home/ec2-user
mkdir -p .certs && mkdir -p .auth
openssl req \
-newkey rsa:4096 -nodes -sha256 -keyout .certs/$PUBLIC_HOSTNAME.key \
-subj "/CN=$PUBLIC_HOSTNAME" \
-x509 -days 365 -out .certs/$PUBLIC_HOSTNAME.crt

docker run --rm \
--entrypoint htpasswd \
registry:2 -Bbn $REGISTRY_USERNAME $REGISTRY_PASSWORD > .auth/htpasswd

sudo mkdir -p /etc/docker/certs.d/$PUBLIC_HOSTNAME:5000
sudo cp .certs/$PUBLIC_HOSTNAME.crt /etc/docker/certs.d/$PUBLIC_HOSTNAME\:5000/ca.crt

docker run -d \
-p 5000:5000 \
--restart=always \
--name registry \
-v /home/ec2-user/.auth:/auth \
-e "REGISTRY_AUTH=htpasswd" \
-e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" \
-e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd \
-v /home/ec2-user/.certs:/certs \
-e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/$PUBLIC_HOSTNAME.crt \
-e REGISTRY_HTTP_TLS_KEY=/certs/$PUBLIC_HOSTNAME.key \
registry:2

echo "=========================================================================="
echo "Registry hostname: $PUBLIC_HOSTNAME"
echo "Username: $REGISTRY_USERNAME"
echo "Password: $REGISTRY_PASSWORD"
echo "=========================================================================="

chown -R ec2-user:ec2-user /home/ec2-user
rm install-docker-registry.sh