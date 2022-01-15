#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset
if ! command -v systemctl >/dev/null 2>&1; then
    echo "> Sorry but this scripts is only for Linux with systemd, eg: Ubuntu 16.04+/Centos 7+ ..."
    exit 1
fi
if [[ $(id -u) -ne 0 ]]; then
    echo "This script must be run as root" 
    exit 1
fi
CLDBIN=/usr/bin/gclone
OSARCH=$(uname -m)
printenv OSARCH
case $OSARCH in 
    x86_64)
        BINTAG=linux-amd64
        ;;
    i*86)
        BINTAG=linux-386
        ;;
    arm64)
        BINTAG=linux-arm64
        ;;
    arm*)
        BINTAG=linux-arm
        ;;
    *)
        echo "unsupported OSARCH: $OSARCH"
        exit 1
        ;;
esac
printenv BINTAG
TAGNAME=$(wget -qO- https://api.github.com/repos/dogbutcat/gclone/releases/latest \ | grep tag_name | cut -d '"' -f 4)
printenv TAGNAME
URL=$(wget -qO- https://api.github.com/repos/dogbutcat/gclone/releases/latest \ | grep browser_download_url | grep "$BINTAG.zip" | cut -d '"' -f 4)
printenv URL
wget -nv ${URL}
ls
unzip -j "gclone-$TAGNAME-$BINTAG.zip" "gclone-$TAGNAME-$BINTAG/gclone" -d "/usr/bin/" && rm gclone-$TAGNAME-$BINTAG.zip
chmod 0755 ${CLDBIN}
gclone version
