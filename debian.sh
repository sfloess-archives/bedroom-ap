#!/bin/sh -x

# ---------------------------------------------------------------------

#
# Enable fuse...
#
modprobe fuse

# ---------------------------------------------------------------------

DEB_DIR=/mnt/admin-ap/debian_armel
mkdir -p ${DEB_DIR}

/opt/bin/nfusr nfs://admin-ap/shared/hosts/bedroom-ap/debian_armel ${DEB_DIR}

mkdir -p ${DEB_DIR}/proc ${DEB_DIR}/sys ${DEB_DIR}/dev ${DEB_DIR}/dev/pts ${DEB_DIR}/tmp ${DEB_DIR}/mnt/bedroom-ap ${DEB_DIR}/lib/modules/`uname -r`

touch  ${DEB_DIR}/etc/mtab ${DEB_DIR}/etc/fstab
cp /etc/mtab ${DEB_DIR}/etc/mtab
cp /etc/mtab ${DEB_DIR}/etc/fstab

# ----------------------------------------------------------------------

chmod    700 ${DEB_DIR}/etc/ssh
chmod -R 700 ${DEB_DIR}/etc/ssh

rm -rf ${DEB_DIR}/run/screen/*

# ----------------------------------------------------------------------

rm -rf ${DEB_DIR}/lib/modules/*                                        
cp -rf /lib/modules/`uname -r` ${DEB_DIR}/lib/modules/  
                                                                        
# ----------------------------------------------------------------------

mkdir -p ${DEB_DIR}/mnt/admin-ap/root ${DEB_DIR}/mnt/bedroom-ap ${DEB_DIR}/dev/pts ${DEB_DIR}/mnt/bedroom-ap ${DEB_DIR}/dev ${DEB_DIR}/proc ${DEB_DIR}/sys ${DEB_DIR}/tmp

# ----------------------------------------------------------------------

#
# Create all mount points in user space...
#
echo "Creating admin-ap mount points for debian:"

mount -t devpts none                  ${DEB_DIR}/dev/pts

mount -o bind /                       ${DEB_DIR}/mnt/bedroom-ap
mount -o bind /dev                    ${DEB_DIR}/dev
mount -o bind /proc                   ${DEB_DIR}/proc
mount -o bind /sys                    ${DEB_DIR}/sys
mount -o bind /tmp                    ${DEB_DIR}/tmp

mount -o bind /tmp/mnt/smbshare       ${DEB_DIR}/mnt/admin-ap/root

for dir in etc home opt/backups opt/media opt/nas opt/shared root opt/shared/hosts/bedroom-ap/debian_armel
do
	DIR=`basename ${dir}`
	LOCAL_DIR=/mnt/admin-ap/${DIR}
	DEB_MOUNT_DIR=${DEB_DIR}/${LOCAL_DIR}

        echo "    [${dir}] -> [${DIR}]  [${DEB_MOUNT_DIR}]"

	mkdir -p ${DEB_MOUNT_DIR}

	/opt/bin/nfusr nfs://admin-ap/${DIR} ${DEB_MOUNT_DIR}
done

# ----------------------------------------------------------------------

/bin/busybox chroot ${DEB_DIR} /mnt/admin-ap/root/Development/github/sfloess/bedroom-ap/debian_startup.sh &

# ---------------------------------------------------------------------

