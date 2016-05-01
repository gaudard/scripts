## Openvswitch setup

ovs-vsctl add-br internalnet0
ovs-vsctl add-br extneralnet0

ip tuntap add mode tap inet0-0
ip tuntap add mode tap inet0-1
ip tuntap add mode tap enet0-0
ip tuntap add mode tap enet0-1

ip link set inet0-0 up
ip link set inet0-1 up
ip link set enet0-0 up
ip link set enet0-1 up

ovs-vsctl add-port internalnet0 inet0-0
ovs-vsctl add-port internalnet0 inet0-1
ovs-vsctl add-port extneralnet0 enet0-0
ovs-vsctl add-port extneralnet0 enet0-1


