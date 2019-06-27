#!/bin/sh

mount.cifs //admin-ap/shared/hosts/bedroom-ap/entware /opt -o credentials=/mnt/smbshare/.root.smb

modprobe fuse

echo "Creating admin-ap mount points:"

for dir in etc home opt/backups opt/media opt/nas opt/shared root
do
        echo "    ${dir}"

	mkdir -p /mnt/admin-ap/`basename ${dir}`
	/opt/bin/nfusr nfs://admin-ap/${dir} /mnt/admin-ap/`basename ${dir}`
done


/opt/etc/init.d/rc.unslung start
