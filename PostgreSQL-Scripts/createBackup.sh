source config.sh

#This is where we create the dump of the database using `pg_dump`
# I fucked around with the flags , please never ever forget about `--format custom`. pg_dump is specifaclly used for custom
# database dumps(such as this) where we assign special flags like --no-owner --clean and --no-privileges
# which ensure that we transfer the database without any ownership/access permission shenanigans. --format custom ensures that
# the flags we set , are actually stored and can be read when we use pg_restore
docker exec $CONTAINER_NAME sh -c "pg_dump -U postgres --format custom --clean $PG_DUMP_FLAGS $DB_NAME > $LOCAL_DUMP_OUTPUT_PATH"
#DO NOT FORGET THE '.' , otherwise you get permission denied to copy (?????????)
docker cp $CONTAINER_NAME:$LOCAL_DUMP_OUTPUT_PATH ./$DB_NAME.sql