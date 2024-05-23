#!/bin/bash

echo "script running"

# Get the IP address of the machine
IP_ADDRESS=$(hostname -I | awk '{print $1}')

# Print the message

sudo echo "Hello from $IP_ADDRESS"  >> /var/www/html/index.nginx-debian.html

sudo systemctl restart nginx.service
sudo systemctl status nginx.service