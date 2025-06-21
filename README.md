# subHttpx

A simple Bash script that leverages **subfinder** and **httpx** to find subdomains, check which ones are live, and run detailed HTTP checks.

---

## Features

- Runs subfinder to discover subdomains and saves it to 'subs.domain.com.subfinder.txt'.
- Checks live hosts among the subdomains using `httpx`.
- Runs detailed `httpx` scans on live subdomains or on all subdomains (based on a flag).
- Runs httpx with additional options (-sc -cl -ct -title -ip -td) for live subdomains. This gives all necessary information
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

'subs.domain.com.subfinder.txt' — all discovered subdomains

'live.subs.domain.com.httpx.txt' — live subdomains detected by httpx

'screenshots.live.subs.domain.com.httpx.txt' — detailed httpx output (all subdomains if -allhttpx flag is used)

