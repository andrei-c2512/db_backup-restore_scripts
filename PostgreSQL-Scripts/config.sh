
CONTAINER_INIT_DURATION=50
CONTAINER_NAME="psql_db"
TAG="17"

USER="user"
PASSWORD="password"
DB_NAME="something"
TARGET_OWNER="LEAFY"
PG_DUMP_FLAGS="--no-owner --no-privileges"
LOCAL_DUMP_OUPUT_PATH="/tmp/$DB_NAME.sql"
OUTPUT_PATH="/data/"

PSQL_DEFAULT_SERVER_SETTINGS="--port 5432 -host localhost"
#echo "$LOCAL_DUMP_OUPUT_PATH"