#!/usr/bin/sh

coredir=`pwd`

. build_bootimg.sh

# copy system files, leave out the dotfiles
cp -rf system/* out

# now let's do the packing
cd out

# test existence of boot.img
status_zip=1
test -f boot.img && echo "packing zip file..." || status_zip=0

# fail if boot.img doesnt exist
if [ ${status_zip} -eq 0 ]; then
    echo "boot.img not present, aborting..." && exit
fi

# ZIP IT!
zip -r $coredir/ROM.zip . -x ".*" -x "*/.*"

cd $coredir
echo "Successfully exported flashable zip as ROM.zip!"
