#!/bin/bash

#./heat_log.sh &
#pid=$!
#sleep 5
#time openstack overcloud deploy --templates --ntp-server 10.5.26.10 --control-scale 1 --compute-scale 1 --neutron-tunnel-types vxlan --neutron-network-type vxlan --libvirt-type kvm --neutron-public-interface eth1
#kill -9 ${pid}

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
--ceph-storage-scale 1 \
--libvirt-type kvm \
--neutron-network-vlan-ranges datacentre:800:900 \
-e ~/templates/tht/environments/network-isolation.yaml \
-e ~/templates/network-environment.yaml \
-e ~/templates/storage-environment.yaml \
-e ~/templates/all.yaml
#-e ~/templates/ceph_osd_setup.yaml \
#-e ~/templates/swap_setup.yaml \
#-e ~/templates/misc_setup.yaml
#--neutron-tunnel-types vxlan \
#--neutron-network-type vxlan \

echo "=> end date"
date
