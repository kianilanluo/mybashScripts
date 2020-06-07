#!/bin/sh
# Jim's backup program
# Runs standalone
# Copies to /data/backups first, then to USB backup drive
VER="File backup by Jim Lewis 5/27/2017 A"
TDIR=/data/backups
RUNDIR=$LDIR/backup
DR=/wd1
echo $VER
cd $RUNDIR
# Insure backup drive is mounted
file $DR | grep broken
a=$?
if [ "$a" != "1" ] ; then
echo "ERROR: USB drive $DR is not mounted!!!!!!!!!!!!!!"
beep
exit 255
fi
date >> datelog.txt
date
echo "Removing files from $TDIR"
cd "$TDIR"
rc=$?
if [ $rc -ne 0 ] ; then
echo "backup1: Error cannot change to $TDIR!"
exit 250
fi
rm *.gz
echo "Backing up files to $TDIR"
X=`date '+%Y%m%d'`
cd /
tar cvzf "$TDIR/lewis$X.gz" lewis
tar cvzf "$TDIR/temp$X.gz" temp
tar cvzf "$TDIR/root$X.gz" root
cd /home
tar cvzf "$TDIR/guest$X.gz" --exclude=Cache --exclude=.cache --
exclude=.evolution --exclude=vmware --exclude=.thumbnails --exclude=.gconf --
exclude=.kde --exclude=.adobe --exclude=.mozilla --exclude=.gconf --
exclude=thunderbird --exclude=.local --exclude=.macromedia --exclude=.config
guest1
cd $RUNDIR
T=`cat filenum1`
BACKDIR=$DR/backups/$T
rm $BACKDIR/*.gz
cd "$TDIR"
cp *.gz $BACKDIR
echo $VER
cd $BACKDIR
pwd
ls -lah
cd $RUNDIR
let T++
if [ $T -gt 7 ] ; then
T=1
fi
echo $T > filenum1
# This is a bit more complicated than the previous scripts so let's go through it line by line:
# The RUNDIR variable holds the starting directory for the scripts.
# The DR variable points to the external backup drive.
# The drive is checked to insure it is mounted.
# The current date is appended to the datelog.txt file.
# The TDIR variable is the target directory for the backups.
# A cd is performed to that directory and the return code is checked. On error the script exits with
# a 250.
# The backups from the previous day are deleted.
# It now goes back to the / directory to perform the tar backups.
# Notice that several directories are excluded from the guest1 directory.
# The cd $RUNDIR puts it back into the starting directory.
# The T=`filenum1` gets the value from that file and puts it into the T variable. This is a counter
# for which directory to use next on the external drive.
# BACKDIR is set to the old backups and then they are removed.
# Control returns again to the starting directory, and the current backups are copied to the
# appropriate directory on the external drive.
# The version of the program is displayed again so that it can be easily found on a cluttered
# screen.
# Control goes to the backup directory, the pwd displays the name, and then the contents of the
# directory are displayed.
# The T variable is incremented by 1. If it is greater than 7 it is set back to 1.
# And finally the updated T variable is written back to the filenum1 file.