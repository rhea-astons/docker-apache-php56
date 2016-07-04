#!/bin/bash

# Generate SSH password
SSH_PASSWORD=`pwgen -c -n -B -1 16`
# Show it in the logs
echo ssh password: $SSH_PASSWORD
# Change it
echo root:$SSH_PASSWORD | chpasswd
# Configure SSH
sed -i 's/PermitRootLogin without-password/PermitRootLogin Yes/' /etc/ssh/sshd_config
sed -i 's/Port 22/Port 7331/' /etc/ssh/sshd_config
# restart SSH service
service ssh restart

# Apache
sed -i 's/example.com/$HOST_NAME/g' /etc/apache2/sites-avaliable/000-default.conf
echo 'ServerName $HOST_NAME' >> /etc/apache2/apache2.conf
read pid cmd state ppid pgrp session tty_nr tpgid rest < /proc/self/stat
trap "kill -TERM -$pgrp; exit" EXIT TERM KILL SIGKILL SIGTERM SIGQUIT
source /etc/apache2/envvars
apache2 -D FOREGROUND