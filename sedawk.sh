#!/bin/bash
cat ./passwd | \
awk '
BEGIN {OFS=FS=":"} 
{
    if (NR>1) {print str}
    if ($1=="saned") {$7="/bin/bash"}
    str=$0;
} END {printf str}' | \
sed '/avahi\:/s:/usr/sbin/nologin:/bin/bash:1' | \
awk 'BEGIN {OFS=FS=":"} {print $1,$3,$5,$7}' | \
sed '/daemon/d' | \
awk '
BEGIN {OFS=FS=":"} 
{   uid=$2%2
    if (uid==0) {$4="/bin/zsh"}
    if (NR>1) {print str}
    str=$0;
} END {print str}' > ./passwd_new