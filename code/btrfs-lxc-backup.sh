#!/bin/bash 
# By Karel Kuna <karel@kuna.space> 


#move to btrfs pool where we have subvolumes to be backed up

cd /mnt/nas


#create read only snapshot (keeping original snapshot)
btrfs subvolume snapshot -r srv/lxc/$1 srv/lxc/snapshots/$1_ro_new
sync
# send difference between old and new snapshot to backup HDD
btrfs send -p srv/lxc/snapshots/$1_ro srv/lxc/snapshots/$1_ro_new | btrfs receive /mnt/backup/backup

#make backup of old subvolume with timestamp at backup HDD

btrfs subvolume snapshot -r /mnt/backup/backup/$1_ro_new /mnt/backup/backup/$1.`date +%Y-%m-%d_%H:%M:%S`

#change new backup to source for next backup on both pools by deleting original snapshot and moving new to original name

#source pool:
btrfs subvolume delete srv/lxc/snapshots/$1_ro
mv srv/lxc/snapshots/$1_ro_new srv/lxc/snapshots/$1_ro                                                              

#backup HDD pool:                                                                                                   

btrfs subvolume delete /mnt/backup/backup/$1_ro                                                                     
mv /mnt/backup/backup/$1_ro_new /mnt/backup/backup/$1_ro