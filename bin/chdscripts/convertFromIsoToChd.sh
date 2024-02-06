#!/bin/bash

# Grab .iso file
for f in ./*.iso
do
	name=${f%.iso} # Remove '.iso' from file name
	chdman createcd -i "$name.iso" -o "$name.chd" --force
done
