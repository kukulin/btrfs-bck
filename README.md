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

		