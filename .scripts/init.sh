#!/usr/bin/env bash

# copy all `.env.example`s to `.env`s
find . -name ".env.example" -exec sh -c 'f="{}"; cp $f $(echo $f | sed "s/.example//g")' \;

# create a virtual environment and install dependencies
python3 -m venv .venv
source .venv/bin/activate
pip install -r .scripts/requirements.txt
