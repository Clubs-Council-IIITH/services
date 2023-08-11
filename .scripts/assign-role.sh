#!/usr/bin/env bash

# helptext
usage() {
	echo "usage: $0 -i <uid> -r <role> [-m <mongo container name>] [-d <mongo database name>] [-u <mongo username>] [-p <mongo password>]" 1>&2
	exit 1
}

# default variable values
db="dev"
container="cc-mongo-1"
username="username"
password="password"

# parse arguments
while getopts ":i:r:d:m:u:p:" o; do
	case "${o}" in
		i)
			uid=${OPTARG}
			;;
		r)
			role=${OPTARG}
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

# input validation
if [ -z "$uid" ] || [ -z "$role" ]; then
	usage
	exit 1
fi

# run command
docker exec $container mongo $db -u $username -p $password --authenticationDatabase admin --eval "db.users.findAndModify({query: { uid: '$uid' }, update: { \$set: { role: '$role' }}, new: true, upsert: true})"

echo "Done!"
