#!/usr/bin/env bash

# helptext
usage() {
	echo "usage: $0 [-f <file.json to upload>] [-c <collection name>] [-d <database name>] [-m <mongo container name>] [-u <mongo username>] [-p <mongo password>]" 1>&2
	exit 1
}

# default variable values
db="dev"
container="cc-dev-mongo-1"
username="username"
password="password"

# parse arguments
while getopts ":f:c:d:m:u:p:" o; do
	case "${o}" in
		f)
			file=${OPTARG}
			;;
		c)
			collection=${OPTARG}
			;;
		d)
			db=${OPTARG}
			;;
		m)
			container=${OPTARG}
			;;
		u)
			username=${OPTARG}
			;;
		p)
			password=${OPTARG}
			;;
		*)
			usage
			;;
	esac
done

# copy file to container
docker cp $file $container:/tmp

# set filename
filename=$(echo $file | rev |cut -d"/" -f 1 | rev)

# import inside container
docker exec $container mongoimport --db $db --collection $collection --type json --file /tmp/$filename --jsonArray --username $username --password $password --authenticationDatabase admin

echo "Done!"
