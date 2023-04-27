import sys
import csv
import json
import bson

from copy import deepcopy

# template user with default fallback values
userModel = {
    "_id": {"$oid": ""},
    "uid": "",
    "img": "",
    "role": "public",
}

if __name__ == "__main__":
    inp_file = sys.argv[1]
    out_file = sys.argv[2]

    # read the CSV file
    csvfile = open(inp_file, "r")
    reader = csv.DictReader(csvfile, delimiter=",")

    # parse the CSV into JSON
    users = []
    for row in reader:
        # create a new user instance
        user = deepcopy(userModel)

        # generate user ID
        _id = str(bson.objectid.ObjectId())

        # set user attributes
        user["_id"]["$oid"] = _id
        user["uid"] = row["uid"]
        user["img"] = row["img"] if row["img"] != "" else f"{user['uid']}.jpg"
        user["role"] = row["role"]

        users.append(user)

    # write to file
    with open(out_file, "w") as f:
        json.dump(users, f, indent=4)

    print(f"Done. Written to {out_file}")
