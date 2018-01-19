#!/usr/bin/sh

cd system

# files to remove
rm -rf `cat files-to-remove.txt`

# replace/add blobs
cp -rf ../kangedblobs/* .