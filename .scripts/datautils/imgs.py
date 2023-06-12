import os
import sys
import json
import bson
import ldap
import shutil

from glob import glob
from copy import deepcopy
from shortuuid import uuid
from werkzeug.utils import secure_filename

from users import userModel

# LDAP connection
LDAP = ldap.initialize("ldap://ldap.iiit.ac.in")


if __name__ == "__main__":
    inp_dir = sys.argv[1]
    out_dir = sys.argv[2]

    users_json = sys.argv[3]
    users = None

    # open users json if provided
    if users_json:
        with open(users_json, "r") as f:
            users = json.load(f)

    # make output directory if it does not exist
    if not os.path.exists(out_dir):
        os.makedirs(out_dir)

    for extension in ["jpeg", "png", "jpg"]:
        # get all files in input directory
        files = glob(os.path.join(inp_dir, f"*.{extension}"))

        # parse each file
        for f in files:
            roll = f.split("/")[-1].split(".")[0]
            uid = '.'.join(f.split("/")[-1].split(".")[:-1])
            try:
                # get uid from rollnumber
                # result = LDAP.search_s("ou=Users,dc=iiit,dc=ac,dc=in", ldap.SCOPE_SUBTREE, filterstr=f"(uidNumber={roll})")
                result = LDAP.search_s("ou=Users,dc=iiit,dc=ac,dc=in", ldap.SCOPE_SUBTREE, filterstr=f"(uid={uid})")
                uid = result[0][1]["uid"][0].decode()

                # construct new filename
                filename = uuid() + "_" + secure_filename(f"{uid}.jpg")

                # save to disk
                shutil.copyfile(f, f"{out_dir}/{filename}")

                # if users json is provided, update it
                if users_json:
                    added = False
                    for user in users:
                        if user["uid"] == uid:
                            user["img"] = filename
                            added = True
                            break

                    if not added:
                        # create a new user instance
                        user = deepcopy(userModel)

                        # generate user ID
                        _id = str(bson.objectid.ObjectId())

                        # set user attributes
                        user["_id"]["$oid"] = _id
                        user["uid"] = uid
                        user["img"] = filename
                        user["role"] = "public"

                        users.append(user)
            except:
                print(f"Failed: {roll}")

    # update users file
    with open(users_json, "w") as f:
        json.dump(users, f, indent=4)

    print("Done.")
