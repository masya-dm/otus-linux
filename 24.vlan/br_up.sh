#!/bin/bash

brctl addbr br0

for i in {1..3}; do
ifconfig eth`echo $i` promisc;
done;

brctl addif br0 eth1 eth2 eth3 
ip link set br0 up