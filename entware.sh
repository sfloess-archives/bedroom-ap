#!/bin/sh

# ---------------------------------------------------------------------

#
# Enable fuse...
#
modprobe fuse

# ---------------------------------------------------------------------

#
# This enables entware on router.  This will give us user space NFS
# client...
#
mount.cifs //admin-ap/shared/hosts/bedroom-ap/entware /opt -o credentials=/mnt/smbshare/.root.smb

#
# Let entware do it's thing
#
/opt/etc/init.d/rc.unslung start

# ---------------------------------------------------------------------

#
# Create all mount points in user space...
#
echo "Creating admin-ap mount points for entware:"

for dir in etc home opt/backups opt/media opt/nas opt/shared root opt/shared/hosts/bedroom-ap/debian_armel
do
        echo "    ${dir}"

	mkdir -p /mnt/admin-ap/`basename ${dir}`
	/opt/bin/nfusr nfs://admin-ap/${dir} /mnt/admin-ap/`basename ${dir}`
done

# ---------------------------------------------------------------------

