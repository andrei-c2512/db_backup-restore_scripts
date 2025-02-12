source config.sh

#dam dump in backup
$WINDOWS_PREFIX docker exec $CONTAINER_NAME mongodump -u $MONGO_USER -p $MONGO_PASS --authenticationDatabase admin --db $DB_NAME --out $LOCAL_BACKUP_DIR

docker cp $CONTAINER_NAME:$LOCAL_BACKUP_DIR $BACKUP_DIR 
#copiem backup-ul me propriul pc
#docker cp $CONTAINER_NAME:$BACKUP_DIR ./mongo_backup

#clean up
#docker stop $CONTAINER_NAME
#docker rm $CONTAINER_NAME