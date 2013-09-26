#!/bin/bash

set -e

set -o pipefail

bj_url="https://raw.github.com/smarthosts/SmartHosts/master/trunk/hosts"  # beijing
us_url="https://raw.github.com/smarthosts/SmartHosts/master/trunk/hosts_us" # usa

url=$us_url
hosts=/etc/hosts
tmp_hosts=/tmp/hosts
filters="GitHub" # "Google\ Services"

sed '/SmartHosts START/,/SmartHosts END/d' $hosts > $tmp_hosts

echo "Downloading hosts from $url"
wget --quiet $url -O - | dos2unix -q | sed -n '/SmartHosts START/,/SmartHosts END/p' >> $tmp_hosts

for f in $filters; do
    sed -i '/'"$f"' START/,/'"$f"' END/d' $tmp_hosts
    echo "Filtered $f"
done

cp -v $hosts $hosts.bak
cp -v $tmp_hosts $hosts

rm -rf $tmp_file
