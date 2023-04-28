# Utility Scripts
Install all dependencies in `requirements.txt` first.

## Data format conversion scripts)

```
date=20230428
python datautils/events.py inp/all_events.csv out/events_$date.json
python datautils/members.py inp/all_members_edited.csv out/members_$date.json
python datautils/users.py inp/all_users.csv out/users_$date.json
python datautils/imgs.py inp/imgs out/imgs_$date out/users_$date.json
```

## Data upload
**Note: The containers have to be running.**

```
./push_data -f out/clubs_$date.json -c clubs
./push_data -f out/events_$date.json -c events
./push_data -f out/users_$date.json -c users
./push_data -f out/members_$date.json -c members
```

```
sudo cp out/imgs_$date/* ../.mounted/files
```
