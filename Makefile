BASE = base7

% :
	if [ -d /var/lib/libvirt/qemu/domain-$@ ] ; \
	then \
		virsh destroy $@ ; \
	fi
	if [ -f /etc/libvirt/qemu/$@.xml ] ; \
	then \
		virsh undefine --remove-all-storage $@ ; \
	fi
	#virt-clone -o base7 -n $@ --auto-clone
	virt-clone -o ${BASE} -n $@ --auto-clone
	virsh start $@
	VNCDISPLAY=`virsh vncdisplay $@` ; vncviewer $$VNCDISPLAY &
