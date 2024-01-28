#!/bin/bash

# Get the IP address
IP_ADDRESS=$(hostname -i)
export IP_ADDRESS

# Get the netmask
NETMASK=$(ip -o -f inet addr show eth0 | awk '{print $4}' | cut -d/ -f2)
NETRANGE=$(ip a | grep global | cut -d" " -f8)
export NETMASK
export NETRANGE

# Optionally, echo the values for logging or verification

echo "IP Address: $IP_ADDRESS"
echo "Netmask: $NETMASK"
echo "NETRANGE: $NET"

# Then, in your `docker-compose.yml` file, you can use the `env_file` directive to load the environment variables into the container:
# socat STDIO UDP4-DATAGRAM:224.1.0.1:6666,bind=:6666,range=$NETRANGE/$NETMASK,ip-add-membership=224.1.0.1:`hostname -i`