#!/bin/bash

export LANG=C
. ~/stackrc
echo "=> start date"
date

echo "=> overcloud deploy"
time openstack overcloud deploy \
--templates ~/templates/tht \
--ntp-server 10.5.26.10 \
--control-flavor control \
--compute-flavor compute \
--swift-storage-flavor control \
--ceph-storage-flavor storage \
--block-storage-flavor control \
--control-scale 1 \
--compute-scale 1 \
--libvirt-type kvm \
--neutron-network-vlan-ranges datacentre:800:900 \
-e ~/templates/tht/environments/network-isolation.yaml \
-e ~/templates/network-environment.yaml \
-e ~/templates/all.yaml

## ceph
#--ceph-storage-scale 1 \
#-e ~/templates/storage-environment.yaml \

## for vxlan
#--neutron-tunnel-types vxlan \
#--neutron-network-type vxlan \

## debug
#-e ~/templates/ceph_osd_setup.yaml \
#-e ~/templates/swap_setup.yaml \
#-e ~/templates/misc_setup.yaml

echo "=> end date"
date
