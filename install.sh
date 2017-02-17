#!/bin/bash
set -e

# use US mirror
sed -i 's/httpredir/ftp.us/g' /etc/apt/sources.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb http://download.mono-project.com/repo/debian wheezy main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list
sudo apt-get update
echo "deb http://download.mono-project.com/repo/debian wheezy-apache24-compat main" | sudo tee -a /etc/apt/sources.list.d/mono-xamarin.list
echo "deb http://download.mono-project.com/repo/debian wheezy-libjpeg62-compat main" | sudo tee -a /etc/apt/sources.list.d/mono-xamarin.list

sudo apt-get update

sudo apt-get install mono-complete
apt-get -y upgrade
apt-get -y install curl libmono-cil-dev supervisor

mkdir -p /build
cd /build

# install jackett
ver=$(curl https://github.com/Jackett/Jackett/releases/latest | sed 's|.*tag/\([^"]\+\).*|\1|')
curl -L -o jackett.tar.gz https://github.com/Jackett/Jackett/releases/download/${ver}/Jackett.Binaries.Mono.tar.gz
tar xvf jackett.tar.gz -C /opt
[[ -d /opt/Jackett ]] || mv /opt/Jackett* /opt/Jackett

# install jackett-public
ver=$(curl https://github.com/dreamcat4/Jackett-public/releases/latest | sed 's|.*tag/\([^"]\+\).*|\1|')
curl -L -o jackett-public.tar.gz https://github.com/dreamcat4/Jackett-public/releases/download/${ver}/Jackett-public.Binaries.Mono.tar.gz
tar xvf jackett-public.tar.gz -C /opt
[[ -d /opt/Jackett-public ]] || mv /opt/Jackett-public* /opt/Jackett-public

cd /
rm -rf /build
apt-get -y clean
rm -rf /var/lib/apt/lists/*
