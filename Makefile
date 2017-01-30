BASE = base7

% :
	if [ -d /var/lib/libvirt/qemu/domain-$@ ] ; \
	then \
		virsh destroy $@ ; \
	fi
	if [ -f /etc/libvirt/qemu/$@.xml ] ; \
	then \
		sleep 5 ; virsh undefine --remove-all-storage $@ ; true ;\
	fi
	if [ -f /home/kschinck/VirtualMachines/$@.qcow2 ] ; \
	then \
		rm -f /home/kschinck/VirtualMachines/$@.qcow2 ; \
	fi
	#virt-clone -o base7 -n $@ --auto-clone
	virt-clone -o ${BASE} -n $@ --auto-clone
	virsh start $@
	VNCDISPLAY=`virsh vncdisplay $@` ; vncviewer $$VNCDISPLAY &

destroy-% :
	if [ -d /var/lib/libvirt/qemu/domain-$@ ] ; \
	then \
		virsh destroy $@ ; \
	fi

undefine-% :
	if [ -f /etc/libvirt/qemu/$@.xml ] ; \
	then \
		virsh undefine --remove-all-storage $@ ; \
	fi
