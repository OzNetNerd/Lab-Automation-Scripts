export PRIVATE_HOSTNAME=$(curl http://169.254.169.254/latest/meta-data/local-hostname)
export PUBLIC_HOSTNAME=$(curl http://169.254.169.254/latest/meta-data/public-hostname)

# install-docker
sudo yum install git -y
sudo amazon-linux-extras install -y docker
sudo systemctl enable docker
sudo systemctl restart docker
sudo usermod -a -G docker ec2-user
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# install docker reigstry
sudo docker pull registry:2

# install gitlab
sudo yum install git -y
sudo docker pull gitlab/gitlab-ce:latest
sudo docker pull docker:stable
sudo docker pull gitlab/gitlab-runner:alpine

# docker-compose
PUBLIC_HOSTNAME=$PUBLIC_HOSTNAME GITLAB_PASSWORD=$GITLAB_PASSWORD GITLAB_TOKEN=$GITLAB_TOKEN docker-compose up -d

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

