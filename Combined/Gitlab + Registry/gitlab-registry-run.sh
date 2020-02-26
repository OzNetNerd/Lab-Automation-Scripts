wget https://raw.githubusercontent.com/OzNetNerd/Lab-Automation-Scripts/master/Docker/install-docker-registry.sh
chmod +x install-docker-registry.sh
REGISTRY_USERNAME=$REGISTRY_USERNAME REGISTRY_PASSWORD=$REGISTRY_PASSWORD ./install-docker-registry.sh
rm gitlab-registry-run.sh

wget https://raw.githubusercontent.com/OzNetNerd/Lab-Automation-Scripts/master/Gitlab/install-gitlab.sh
chmod +x install-gitlab.sh
GITLAB_PASSWORD=$GITLAB_PASSWORD GITLAB_TOKEN=$GITLAB_TOKEN ./install-gitlab.sh
rm install-gitlab.sh