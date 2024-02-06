#!/bin/bash

# Grab .cue file
for f in ./**/*.cue
do
	name=${f%.cue} # Remove '.cue' from file name
	chdman createcd -i "$name.cue" -o "$name.chd" --force
done
