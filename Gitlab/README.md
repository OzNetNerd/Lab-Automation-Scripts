# Instructions

Sets up GitLab and a GitLab runner. 

## Security Group

The following inbound port is required:

* 80

## Environment Variables

The following environment variables are required:

* GITLAB_PASSWORD - _Note: Must meet GitLab's minimum password criteria_
* GITLAB_TOKEN - _A random string_

## Example

```
bash <(curl -s https://raw.githubusercontent.com/OzNetNerd/Lab-Automation-Scripts/master/Docker/install-docker.sh)
wget https://raw.githubusercontent.com/OzNetNerd/Lab-Automation-Scripts/master/Gitlab/install-gitlab.sh
chmod +x install-gitlab.sh
GITLAB_PASSWORD=TrendDevOps GITLAB_TOKEN=K324jhkdsfHJKSk29 ./install-gitlab.sh
```

Once the script runs to completion, browse to `http://<EC2-PUBLIC-HOSTNAME`. Log in with username `root` and the password you specified above. 