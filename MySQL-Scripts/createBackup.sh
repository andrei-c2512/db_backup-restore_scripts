source config.sh



$WINDOWS_PREFIX docker exec $CONTAINER_NAME bash -c "
mkdir $LOCAL_BACKUP_DIR
mysqldump -u$USER -p$PASSWORD --routines --events --databases $DB_NAME > $LOCAL_BACKUP_DIR/$BACKUP_FILE_NAME
"
docker cp $CONTAINER_NAME:$LOCAL_BACKUP_DIR/$BACKUP_FILE_NAME ./$BACKUP_DIR/$BACKUP_FILE_NAME