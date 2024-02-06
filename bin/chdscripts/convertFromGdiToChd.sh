#!/bin/bash

# Grab .gdi file
for f in ./**/*.gdi
do
	name=${f%.gdi} # Remove '.gdi' from file name
	chdman createcd -i "$name.gdi" -o "$name.chd" --force
done
