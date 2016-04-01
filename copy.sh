#! /bin/sh
#$1 path of raw image
#$2 mount offset
#$3 path to mount
#$4 file to copy
#$5 relative path to mount directory
sudo mount $5 -o loop,offset=$4 $2
sudo cp $1 $2/$3
