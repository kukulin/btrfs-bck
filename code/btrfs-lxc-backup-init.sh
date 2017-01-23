#!/bin/bash 
# By Karel Kuna <karel@kuna.space> 
                                                                                           
#initial snapshot and transfer to backup HDD  

#In this case we make read only snapshot of LXC container which name is given in parameter 1 in command
#this part needs to be done by parameter                                                                      
cd /mnt/nas                                                                                                         

# paths to volumes must be passed as parameters - here we create read only snapshot
btrfs subvolume snapshot -r srv/lxc/$1 srv/lxc/snapshots/$1_ro

#sync will assure that all data in read only snapshot were already written
sync

#transfer complete snapshot to another physical disk (second btrfs pool) - here mounted to /mnt/backup
btrfs send srv/lxc/snapshots/$1_ro | btrfs receive /mnt/backup/backup