# btrfs-bck
personal backup solution for btrfs subvolumes at Turris Omnia router


Target is to have automatized backup for my environment on Turris Omnia ruter
Functionality :
		- Create backup of virtual machines (in subvolumes) daily on current subvolumes
		- Transfer backup to another HDD mounted in system (2nd USB HDD)
		- Keep last 7 daily backups for each subvolumes at 2nd HDD
		- Keep 6 monthly backups on 2nd HDD
		- Keep only 1 read only snapshot (latest version) at current disk to be used for incremental send operation for next backup
		- be universal - called with parameters 1 - subvolume to backup 
		- check if initial read only subvolume exists - if not, create it (like initialization)
		