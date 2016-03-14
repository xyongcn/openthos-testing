#! /bin/sh
sudo apt-get update
sudo apt-get install openjdk-8-jdk
sudo apt-get install git-core gnupg flex bison gperf build-essential \
  zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 \
  lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache \
  libgl1-mesa-dev libxml2-utils xsltproc unzip genisoimage isohybrid \
  libgbm-dev libsdl2-dev libgtk-3-dev libgles2-mesa-dev libpixman-1-dev libtool autoconf lantern
mkdir ~/bin
PATH=~/bin:$PATH
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
mkdir android-repo
cd android-repo
export http_proxy=127.0.0.1:8787
export https_proxy=127.0.0.1:8787
repo init -u git://gitscm.sf.net/gitroot/android-x86/manifest -b $1
repo sync
source build/envsetup.sh
lunch android_x86_64-eng
make -j8 iso_img
