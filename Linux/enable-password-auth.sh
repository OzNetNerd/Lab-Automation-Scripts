#!/bin/bash

echo $SSH_PASSWORD | passwd ec2-user --stdin
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config
service sshd restart

rm enable-password-auth.sh