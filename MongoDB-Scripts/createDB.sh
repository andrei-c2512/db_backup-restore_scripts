# Set variables
source config.sh

# Run MongoDB container
echo "Starting MongoDB container..."
docker run -d --name $CONTAINER_NAME -e MONGO_INITDB_ROOT_USERNAME=$MONGO_USER -e MONGO_INITDB_ROOT_PASSWORD=$MONGO_PASS -p 27017:27017 mongo:latest

# Wait for MongoDB to start
echo "Waiting for MongoDB to start..."
sleep 10

# Create database and collection using MongoDB shell
echo "Creating database and collection..."
docker exec -i $CONTAINER_NAME mongosh -u $MONGO_USER -p $MONGO_PASS --authenticationDatabase admin <<EOF
use $DB_NAME;
db.createCollection("$COLLECTION_NAME");
db.$COLLECTION_NAME.insertOne({ name: "Sample Data" });
EOF

echo "Database and collection created successfully!"