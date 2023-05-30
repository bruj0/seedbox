#!/bin/bash -x
ECHO=""
for i in "$@"; do
  case $i in
	d|--dry-run)
      	DRY_RUN=true
      	ECHO="echo"
	;;
  	*)
  	;;
  esac
done

SERVICES=(
"traefik"
"plex"
"duplicati"
"deluge"
"portainer"
"heimdall"
"vaultwarden")


for str in ${SERVICES[@]}; do
  $ECHO docker compose --env-file .env -f services/$str.yaml up -d 
done

rclone --vfs-cache-mode writes mount --allow-other OneDrive1: /mnt/onedrive/ &

rclone --vfs-cache-mode writes mount --allow-other GoogleDrive1: /mnt/googledrive/ &
