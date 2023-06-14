import sys
import csv
import json
import bson

from copy import deepcopy

# template member with default fallback values
memberModel = {
    "_id": "",
    "cid": "",
    "uid": "",
    "poc": False,
    "roles": [],
}

if __name__ == "__main__":
    inp_file = sys.argv[1]
    out_file = sys.argv[2]

    # read the CSV file
    csvfile = open(inp_file, "r")
    reader = csv.DictReader(csvfile, delimiter=",")

    seen_members = set()

    # parse the CSV into JSON
    members = []
    for row in reader:
        # create a new user instance
        member = deepcopy(memberModel)

        # generate member and role ID
        _id = str(bson.objectid.ObjectId())
        rid = str(bson.objectid.ObjectId())

        # set member attributes
        member["_id"] = _id
        member["cid"] = row["club_mail"].split("@")[0]
        member["uid"] = row["mail"].split("@")[0]
        key = f"{member['cid']}_{member['uid']}"

        if key in seen_members:
            tgt_member = next(x for x in members if f"{x['cid']}_{x['uid']}" == key)

            # check if member is continuing in the same role
            if tgt_member["roles"][-1]["name"] != row["role"]:
                tgt_member["roles"][-1]["end_year"] = row["year"]
                tgt_member["roles"].append(
                    {
                        "rid": rid,
                        "name": row["role"],
                        "start_year": row["year"],
                        "end_year": None,
                        "approved": True,
                        "deleted": False,
                    }
                )
            else:
                # update start year if an earlier year is found
                tgt_member["roles"][-1]["start_year"] = min(
                    row["year"], tgt_member["roles"][-1]["start_year"]
                )

        else:
            member["roles"].append(
                {
                    "rid": rid,
                    "name": row["role"],
                    "start_year": row["year"],
                    "end_year": None,
                    "approved": True,
                    "deleted": False,
                }
            )
            seen_members.add(key)
            members.append(member)

    # write to file
    with open(out_file, "w") as f:
        json.dump(members, f, indent=4)

    print(f"Done. Written to {out_file}")
