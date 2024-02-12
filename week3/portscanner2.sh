#!/bin/bash

# Check if required parameters are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <network_prefix> <port>"
    exit 1
fi

network_prefix=$1
port=$2

# Function to perform port scan using nc
perform_port_scan() {
    local host=$1
    local port=$2
    (echo >/dev/tcp/$host/$port) &>/dev/null
    if [ $? -eq 0 ]; then
        echo "Open port $port on host $host"
    fi
}

# Iterate through the IP addresses in the network prefix and perform port scan
for i in $(seq 1 254); do
    ip="$network_prefix.$i"
    perform_port_scan $ip $port &
done

# Wait for all background processes to finish
wait

echo "Port scan completed."
