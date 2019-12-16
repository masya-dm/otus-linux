#!/bin/bash

VER=`yum info easy-rsa | grep Version | awk '{print$3}'`

function genkey ()
{
    cd /etc/openvpn
    /usr/share/easy-rsa/`echo $VER`/easyrsa init-pki
    echo 'rasvpn' | /usr/share/easy-rsa/`echo $VER`/easyrsa build-ca nopass
    echo 'rasvpn' | /usr/share/easy-rsa/`echo $VER`/easyrsa gen-req server nopass
    echo 'yes' | /usr/share/easy-rsa/`echo $VER`/easyrsa sign-req server server
    /usr/share/easy-rsa/`echo $VER`/easyrsa gen-dh
    openvpn --genkey --secret ta.key
    echo 'client' | /usr/share/easy-rsa/`echo $VER`/easyrsa gen-req client nopass
    echo 'yes' | /usr/share/easy-rsa/`echo $VER`/easyrsa sign-req client client

}

if [ -d /etc/openvpn/pki/  ]; then
    rm -rf /etc/openvpn/pki/
    genkey
    exit 0
else
   genkey
   exit 0
fi
    
    
