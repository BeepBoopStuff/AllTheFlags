########################################################################################
### Author: BeepBoopStuff                                                            ###
### Overview: Quick script to streamline vhost discovery with Gobuster               ###
########################################################################################

#!/bin/bash
## Check if gobuster is installed 
if ! command -v gobuster 2>&1 >/dev/null
then
    echo "You must install gobuster first"
    exit 1
fi

## Get domain from user
read -p "Enter url: " url
domain=$(echo "$url" | cut -d '/' -f3)

## Check for wordlist
if [ "$1" == "--wordlist" ] && [ -n "$2" ]; then
    if [ -f "$2" ]; then
        wordlist=$2
    else
        wordlist="/usr/share/wordlists/seclists/Discovery/DNS/subdomains-top1million-5000.txt"
    fi
else
    wordlist="/usr/share/wordlists/seclists/Discovery/DNS/subdomains-top1million-5000.txt"
fi


## Get exclude 
read -p "Exclude length: " exclude_len

## Check if we can reach domain
if ping -c 1 -W 2 "$domain" > /dev/null 2>&1; then
    pass
else
    echo "Domain $domain is not reachable"
    exit 1
fi

## Write domain pattern
echo "{GOBUSTER}.${domain}" > /tmp/vhost_domain

## Run gobusters
if [ ${#exclude_len} -gt 0 ]; then
    gobuster vhost -u $url --wordlist $wordlist -p /tmp/vhost_domain --exclude-length $exclude_len
else
    echo "No exclusion value given, allow all response lengths..."
    gobuster vhost -u $url --wordlist $wordlist -p /tmp/vhost_domain
fi

## Clean-up
rm -f /tmp/vhost_domain

