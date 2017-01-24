# btrfs-bck
personal backup solution for btrfs subvolumes at Turris Omnia router


Target is to have automatized backup for my environment on Turris Omnia ruter with following functionality :

- Create snapshot of defined subvolumes daily on current btrfs pool (actually mounted to /mnt/nas)
- Transfer backup to another HDD mounted in system (2nd USB HDD) (using btrfs send/receive) - transfer done in incremental mode
- Keep last 7 daily backups for each subvolumes at 2nd HDD
- Keep 6 monthly backups on 2nd HDD
- Keep only 1 read only snapshot (latest version) at original btrfs pool to be used for incremental send operation for next backup
- be universal - called with parameters 
- check if initial read only subvolume exists - if not, create it (like initialization) - avoid manual creation of initial backup
- logging of operation with verbosity defined in parameters
-



# Current status :

2 snippets following logic from  https://btrfs.wiki.kernel.org/index.php/Incremental_Backup

btrfs_pool_orig  = /mnt/nas
this is the root of btrfs filesystem where are located subvolumes we want to backup

btrfs_pool_backup = /mnt/backup/backup/
this is the root filesystem of btrfs backup HDD

Scripts has 1 parameter - name of folder with LXC container to back up


# code/btrfs-lxc-backup-init.sh  
	create initial read only snapshot of subvolume from folder /mnt/nas/srv/lxc/"name of container - 1st parameter of script"
	and transfer full copy of this read only subvolume to /mnt/backup/backup/"path of original subvolume at btrfs_pool_orig" 
	
# code/btrfs-lxc-backup.sh
	create new snapshot of subvolume  and send difference to btrfs_pool_backup
	create snapshot with timestamp of transferred subvolume at btrfs_pool_backup  
	
	move new copy to read only snapshot at btrfs_pool_orig  (now we have only latest snapshot here to be used for next diferential send)
	
	move new copy to read only snapshot at btrfs_pool_backup (now we have only latest snapshot here to be used for next diferential receive)
	
