#!/bin/bash

host=$1
startport=$2
endport=$3

exec 2>/dev/null;

# function pingcheck
# ping to see if device is up

function pingcheck
{
    ping=`ping -c 1 $host | grep bytes | wc -l`;
    if [ "$ping" -gt 1 ]; then
        echo "$host is up";
    else 
        echo "$host is down, quitting";
        exit
    fi
}

# function portcheck
# test to see if a port is open

function portcheck
{
    for ((counter=$startport; counter<=$endport; counter++))
    do
    (echo > /dev/tcp/$host/$counter > /dev/null 2>&1 && echo "$counter open")
    done
}

pingcheck
portcheck