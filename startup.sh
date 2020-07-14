#!/bin/bash

mkdir -p /data
cd /data

apt-ftparchive packages amd64 > Packages
gzip -k -f Packages

apt-ftparchive release . > Release

gpg --import /gpg/gpg.key /gpg/gpg.pub
cp /gpg/gpg.pub /data/KEY.gpg

export KEYID=$(</gpg/fingerprint)

rm -fr Release.gpg; gpg --default-key ${KEYID} -abs -o Release.gpg Release
rm -fr InRelease; gpg --default-key ${KEYID} --clearsign -o InRelease Release

exec /usr/sbin/nginx -g 'daemon off;'
