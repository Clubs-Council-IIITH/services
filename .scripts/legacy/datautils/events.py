import sys
import csv
import json
import bson

from copy import deepcopy

# template event with default fallback values
eventModel = {
    "_id": "",
    "name": "",
    "clubid": "",
    "datetimeperiod": ["", ""],
    "status": {
        "state": "approved",
        "room": True,
        "budget": True,
    },
    "description": "No description available",
    "mode": "hybrid",
    "poster": None,
    "audience": [],
    "link": None,
    "location": [],
    "equipment": None,
    "additional": None,
    "population": None,
    "budget": [],
}

# valid audience
validAudience = set({"ug1", "ug2", "ug3", "ug4", "pg", "fac", "stf"})

if __name__ == "__main__":
    inp_file = sys.argv[1]
    out_file = sys.argv[2]

    # read the CSV file
    csvfile = open(inp_file, "r")
    reader = csv.DictReader(csvfile, delimiter=",")

    # parse the CSV into JSON
    events = []
    for row in reader:
        # create a new event instance
        event = deepcopy(eventModel)

        # generate event ID
        _id = str(bson.objectid.ObjectId())

        # set event attributes
        event["_id"] = _id
        event["name"] = row["name"]
        event["clubid"] = row["club_mail"].split("@")[0]
        event["datetimeperiod"] = [row["datetimeStart"], row["datetimeEnd"]]
        event["description"] = row["description"]
        event["poster"] = row["poster"] if row["poster"] != "" else None
        event["audience"] = (
            row["audience"]
            .replace("internal", "ug1,ug2,ug3")
            .replace("ugx", "ug4")
            .replace("staff", "stf")
            .replace("faculty", "fac")
            .split(",")
        )

        # constraints
        if set(event["audience"]).issubset(validAudience):
            events.append(event)
        else:
            print(f"Failed: {event}")

    # write to file
    with open(out_file, "w") as f:
        json.dump(events, f, indent=4)

    print(f"Done. Written to {out_file}")
