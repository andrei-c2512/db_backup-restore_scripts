source config.sh

#WARNING , everytime you see any postgres binary called without a password , it's because I already set the password
#as a enviroment variable that is recognized by postgres
#WARNING , this restore does NOT solve any other permission related stuff other than transfering the ownership , only the ownership
#any other roles you created you have set previously , are your responsability to fix , not of this script 
#this script isn't even fully automated , because when you call `pg_restore`  , you still have to enter your password for the 
#restore to occur. This script is more or less , a guideline


#here we drop the old database , to make room for the restore
echo "Dropping the old database"
docker exec $CONTAINER_NAME sh -c "dropdb -U postgres --if-exists  "$DB_NAME""

#here we create an empty database , with our preffered owner
echo "Creating a new database with the desired owner"
docker exec sh -c "createdb -U postgres --owner "$TARGET_OWNER" -T template0 "$DB_NAME""

#here we upload our backup file , from our own machine , to the container to use it in the next command
echo "Uploading the backup file to the container"
docker cp ./$DB_NAME.sql $CONTAINER_NAME:$LOCAL_BACKUP_DIR/$DB_NAME.sql

#we restore the database from the file we previously uploaded on this container.
#the psql default server settings are just the usual stuff you have to type all the time: host and port
#the pg dump flags are the flags we used for our custom dumps
#pg restore , as well is used for custom restores , otherwise you use psql for simple restores. But we don't want to deal
#with access/permission shenanigans so we do work like this
echo "Restoring the database"
docker exec sh -c "pg_restore $PSQL_DEFAULT_SERVER_SETTINGS --username "$TARGET_OWNER" --password --dbname "$DB_NAME" $PG_DUMP_FLAGS "$DUMP_FILE""
