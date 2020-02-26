# install-docker.sh

Installs Docker and docker-compose.

## Example

Run the script:

```
bash <(curl -s https://raw.githubusercontent.com/OzNetNerd/Lab-Automation-Scripts/master/Docker/install-docker.sh)
```

# install-docker-registry.sh

Installs Docker, docker-compose and sets up a local Docker registry.

## Environment Variables

The following environment variables are required:

* REGISTRY_USERNAME
* REGISTRY_PASSWORD

## Security Group

The following inbound port is required:

* 5000

## Example

Run the script:

```
wget https://raw.githubusercontent.com/OzNetNerd/Lab-Automation-Scripts/master/Docker/install-docker-registry.sh
chmod +x install-docker-registry.sh
REGISTRY_USERNAME=root REGISTRY_PASSWORD=toor ./install-docker-registry.sh
```
* Log into the registry:

```
docker login ec2-13-54-159-210.ap-southeast-2.compute.amazonaws.com
Username: root
Password: 
```