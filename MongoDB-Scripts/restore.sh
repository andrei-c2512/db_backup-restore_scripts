source config.sh

docker cp $BACKUP_DIR/$DB_NAME $CONTAINER_NAME:$LOCAL_BACKUP_DIR 
docker exec $CONTAINER_NAME mongorestore -u $MONGO_USER -p $MONGO_PASS --authenticationDatabase admin --db $DB_NAME $LOCAL_BACKUP_DIR/$DB_NAME