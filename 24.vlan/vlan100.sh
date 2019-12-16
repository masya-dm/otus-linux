#!/bin/bash

HN=`hostname -s`

function VLAN {
ip link add link eth1 name eth1.100 type vlan id 100
ip a add $1 dev eth1.100
ip link set eth1.100 up
}

if [ "$HN" = "test1client" ]; then 
    VLAN 10.10.10.1/24;
    else VLAN 10.10.10.254/24;
fi