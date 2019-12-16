#!/bin/bash

HN=`hostname -s`

function VLAN {
ip link add link eth1 name eth1.101 type vlan id 101
ip a add $1 dev eth1.101
ip link set eth1.101 up
}

if [ "$HN" = "test2client" ]; then 
    VLAN 10.10.10.1/24;
    else VLAN 10.10.10.254/24;
fi