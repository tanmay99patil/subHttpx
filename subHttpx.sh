#!/bin/bash

# Function to display manual/usage information
show_man() {
    echo "
Usage: $0 <domain> [-allhttpx]

Steps:
1. Run subfinder to discover subdomains and save to 'subs.domain.com.subfinder.txt'.
2. Run httpx on all discovered subdomains and save live subdomains to 'live.subs.domain.com.httpx.txt'.
3. Run httpx with additional options (-sc -cl -ct -title -ip -td) for live subdomains and save to 'screenshots.live.subs.domain.com.httpx.txt'.
4. Optional: Run httpx with additional options on all subdomains (if '-allhttpx' flag is provided) and save to 'screenshots.subs.domain.com.httpx.txt'.

Flags:
    -allhttpx  Run the fourth step which performs HTTP checks on all subdomains (optional).

Examples:
    1. To run the script without the -allhttpx flag (default behavior):
       $0 domain.com
    2. To include the fourth step (httpx on all subdomains):
       $0 domain.com -allhttpx

Dependencies:
    - subfinder: Subdomain discovery tool
    - httpx: HTTP probing tool

    Both can be installed via 'go install' or by following their respective installation guides.
    "
    exit 0
}

# Check if domain is provided or if -man flag is present
if [ "$1" == "-man" ]; then
    show_man
fi

# Check if domain is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <domain> [-allhttpx]"
    exit 1
fi

DOMAIN="$1"
DOMAIN_FOLDER="$DOMAIN"
ALL_HTTPX_FLAG="$2"  # Capture the second argument (if provided)

# Create folder for the domain
mkdir -p "$DOMAIN_FOLDER"
cd "$DOMAIN_FOLDER" || exit

# Step 1: Run subfinder to find subdomains and save to a file
echo "[+] Running Subfinder for $DOMAIN"
subfinder -d "$DOMAIN" -all | tee "subs.$DOMAIN.subfinder.txt"

# Step 2: Run httpx to find live subdomains and save to a file
echo "[+] Running httpx to check live subdomains for $DOMAIN"
cat "subs.$DOMAIN.subfinder.txt" | httpx | tee "live.subs.$DOMAIN.httpx.txt"

# Step 3: Run httpx with options on the live subdomains and save to a file
echo "[+] Running httpx with options for live subs of $DOMAIN"
cat "live.subs.$DOMAIN.httpx.txt" | httpx -sc -cl -ct -title -ip -td | tee "screenshots.live.subs.$DOMAIN.httpx.txt"

# Step 4: Run httpx with options on all subdomains if -allhttpx flag is provided
if [ "$ALL_HTTPX_FLAG" == "-allhttpx" ]; then
    echo "[+] Running httpx with options for all subs of $DOMAIN"
    cat "subs.$DOMAIN.subfinder.txt" | httpx -sc -cl -ct -title -ip -td | tee "screenshots.subs.$DOMAIN.httpx.txt"
fi

echo "[+] Recon for $DOMAIN completed. Results saved in $DOMAIN_FOLDER/"
