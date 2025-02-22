source config.sh

#we launch the container with the postgres password enviroment variable set , for easier binary calls
docker run --name $CONTAINER_NAME -e POSTGRES_PASSWORD=$PASSWORD -d postgres:$TAG

#WARNING , everytime you see any postgres binary called without a password , it's because I already set the password
#as a enviroment variable that is recognized by postgres

echo "Waiting $CONTAINER_INIT_DURATION seconds for the container to fully initialise"
sleep $CONTAINER_INIT_DURATION

#In the following calls , we create a dummy database that you can run the later scripts on
echo "Creating the database..."
docker exec $CONTAINER_NAME sh -c "psql -U postgres << EOF
CREATE DATABASE $DB_NAME;
\q
EOF"

echo "Creating a table inside the database..."
docker exec $CONTAINER_NAME sh -c "psql -U postgres $DB_NAME << EOF
CREATE TABLE test ( val INT PRIMARY KEY , name varchar(50));
INSERT INTO test VALUES(0 , 'Floppa');
INSERT INTO test VALUES(1, 'Halompa');

CREATE USER leafy WITH PASSWORD 'AsiiItBoss';

\q
EOF"

echo "Testing by running a select all query..."
docker exec $CONTAINER_NAME sh -c "psql -U postgres $DB_NAME << EOF
    SELECT * FROM test;
\q
EOF"