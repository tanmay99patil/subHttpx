# subHttpx

A simple Bash script that leverages **subfinder** and **httpx** to find subdomains, check which ones are live, and run detailed HTTP checks.

---

## Features

- Finds subdomains of a given domain using `subfinder`.
- Checks live hosts among the subdomains using `httpx`.
- Runs detailed `httpx` scans on live subdomains or on all subdomains (based on a flag).
- This are the flags used as it gives almost all necessary details `-sc -cl -ct -title -ip -td` 
- Saves all outputs in a dedicated folder named after the domain.
- Outputs are separated for clarity: subs, live subs, detailed httpx scans, etc.

---

## Requirements

- [subfinder](https://github.com/projectdiscovery/subfinder)
- [httpx](https://github.com/projectdiscovery/httpx)
- Bash shell (Linux/MacOS/WSL)

Make sure both tools are installed and accessible in your `PATH`.

---

## Usage

```bash
# Basic usage: runs on live subdomains only
./subHttpx.sh domain.com

# Run detailed httpx flags on all subdomains (live or not)
./subHttpx.sh domain.com -allhttpx

## Output
Outputs are saved inside a folder named after the domain:

subs.txt — all discovered subdomains

live_subs.txt — live subdomains detected by httpx

httpx_all.txt — detailed httpx output (all subdomains if -allhttpx flag is used)

