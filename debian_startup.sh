#!/bin/sh

# ---------------------------------------------------------------------

depmod
modprobe fuse

# ---------------------------------------------------------------------

/usr/sbin/ntpdate-debian

# ---------------------------------------------------------------------

chmod -R 700 /root/.ssh
chmod 775 /run/screen

chmod u+s /usr/bin/sudo
chmod g+s /usr/bin/sudo

chmod 700 -R /etc/ssh /var/run/sshd

# ---------------------------------------------------------------------

/etc/init.d/rsyslog    start
/etc/init.d/ntp        start
/etc/init.d/cron       start
/etc/init.d/rpcbind    start
/etc/init.d/postfix    start
/etc/init.d/nis        start
/etc/init.d/ssh        start
/etc/init.d/rsync      start

# ---------------------------------------------------------------------

