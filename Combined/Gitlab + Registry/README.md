# Instructions

Sets up GitLab, a GitLab runner and a local Docker registry. 

## Security Group

The following inbound ports are required:

* 80
* 5000

## Environment Variables

The following environment variables are required:

* GITLAB_PASSWORD - _Note: Must meet GitLab's minimum password criteria_
* GITLAB_TOKEN
* REGISTRY_USERNAME
* REGISTRY_PASSWORD

## Example

```
wget https://raw.githubusercontent.com/OzNetNerd/Lab-Automation-Scripts/master/Combined/Gitlab%20%2B%20Registry/gitlab-registry-run.sh
chmod +x gitlab-registry-run.sh
REGISTRY_USERNAME=root REGISTRY_PASSWORD=TrendDevOps GITLAB_PASSWORD=TrendDevOps GITLAB_TOKEN=toor ./gitlab-registry-run.sh
```
