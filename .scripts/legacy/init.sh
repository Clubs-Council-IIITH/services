#!/usr/bin/env bash

# copy all `.env.example`s to `.env`s
find . -name ".env.example" -exec sh -c 'f="{}"; cp $f $(echo $f | sed "s/.example//g")' \;
