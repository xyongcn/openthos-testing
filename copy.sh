#! /bin/sh
#$1 path of raw image
#$2 mount offset
#$3 path to mount
#$4 file to copy
#$5 relative path to mount directory
sudo mount $1 -o loop,offset=$2 $3
sudo cp $4 $3/$5
