#!/bin/bash

#Variables for server and network prefix
prefix=$1
server=$2

#Function that loops through the network prefix and nslookups each IP found
function nslook

{
	echo "resolving dns for $prefix"
	for i in $(seq 1 254); do
		(nslookup $prefix.$i $server | grep 'name')
	done
}

nslook
