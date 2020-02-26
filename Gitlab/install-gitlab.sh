#!/bin/bash

sudo yum install git -y
sudo docker pull gitlab/gitlab-ce:latest
sudo docker pull docker:stable
sudo docker pull gitlab/gitlab-runner:alpine

export PRIVATE_HOSTNAME=$(curl http://169.254.169.254/latest/meta-data/local-hostname)
export PUBLIC_HOSTNAME=$(curl http://169.254.169.254/latest/meta-data/public-hostname)

wget https://raw.githubusercontent.com/OzNetNerd/Lab-Automation-Scripts/master/Gitlab/docker-compose.yaml
PUBLIC_HOSTNAME=$PUBLIC_HOSTNAME GITLAB_PASSWORD=$GITLAB_PASSWORD GITLAB_TOKEN=$GITLAB_TOKEN docker-compose up -d
rm docker-compose.yaml

echo "Sleeping for 4 minutes to give Gitlab time to start"
sleep 240

echo "Starting Gitlab runner..."
docker exec -it gitlab-runner \
gitlab-runner register -n \
--url http://$PRIVATE_HOSTNAME \
--registration-token $GITLAB_TOKEN \
--executor docker \
--description "Gitlab Runner" \
--docker-image "docker:stable" \
--docker-privileged \
--locked=false \
--docker-volumes /etc/docker/certs.d:/etc/docker/certs.d

echo "=========================================================================="
echo "Gitlab URL: http://$PUBLIC_HOSTNAME"
echo "Username: root"
echo "Password: $GITLAB_PASSWORD"
echo "=========================================================================="

rm install-gitlab.sh