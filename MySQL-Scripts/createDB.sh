source config.sh

docker run --name $CONTAINER_NAME -e MYSQL_ROOT_PASSWORD=$PASSWORD -d mysql:$TAG

until $WINDOWS_PREFIX docker exec $CONTAINER_NAME mysqladmin ping -u$USER -p$PASSWORD --silent; do
    echo "Waiting for mySQL server to fucking start"
    sleep 2
done

#cred ca il poti mai mic wait-ul 
echo "Sleeping for maximum a minute"
echo "Waiting for my baby MySQL to initialise , we can't yet disturb it with garbage sql commands"

sleep 60
#aparent NU trebuie spatiu intre argumente. Ciudata conventie
$WINDOWS_PREFIX docker exec $CONTAINER_NAME sh -c "mysqlsh --sql -u$USER -p$PASSWORD <<EOF
    CREATE DATABASE $DB_NAME;
    USE $DB_NAME;
    CREATE TABLE slaves(name VARCHAR(50) NOT NULL , tasksCompleted INT NOT NULL);
    INSERT INTO slaves VALUES(\"Eu\" , 314);
    INSERT INTO slaves VALUES(\"Amogus\" , 10000);
EOF"

$WINDOWS_PREFIX docker exec -i $CONTAINER_NAME mysql -u$USER -p$PASSWORD -e "SHOW DATABASES;"