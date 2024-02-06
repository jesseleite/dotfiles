#!/bin/bash

# Grab .chd file
for f in ./**/*.chd
do
	name=${f%.chd} # Remove '.chd' from file name
	chdman extractcd -i "$name.chd" -o "$name.gdi" --force
done
