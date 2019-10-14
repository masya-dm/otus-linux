#!/bin/bash
ADM=`groups $PAM_USER | grep admin`; 
DATE=`date +%u`;
if [ -z "$ADM" ]; then 
  case $DATE in
    6|7)
    exit 1;
    ;;
    *)
    exit 0;
    ;;
  esac
 else 
  exit 0;
fi;
