"# OSS-Project-Rishi" 
# OSS Audit — Apache HTTP Server
### Open Source Software Capstone Project

| Field | Details |
|---|---|
| **Student Name** | [Rishi Raj] |
| **Roll Number** | [24BAI10118] |
| **Course** | Open Source Software (NGMC) |
| **Chosen Software** | Apache HTTP Server |
| **License** | Apache License 2.0 |
| **Repository** | oss-audit-[24BAI10118] |

---

## Repository Structure

```
oss-audit-[24BAI10118]/
│
├── README.md                          ← You are here
├── script1_system_identity.sh         ← System welcome screen
├── script2_package_inspector.sh       ← Package install checker
├── script3_disk_permission_auditor.sh ← Directory audit
├── script4_log_analyzer.sh            ← Apache log scanner
└── script5_manifesto_generator.sh     ← Manifesto generator
```

---

## Dependencies / Requirements

- A Linux system (Ubuntu, Debian, CentOS, Fedora, or any RHEL-based distro)
- Bash shell (version 4.0 or higher) — comes pre-installed on all Linux systems
- Apache HTTP Server installed (required for Scripts 2, 3, and 4)
- No external libraries or pip/npm packages needed

> **Check your Bash version:**
> ```bash
> bash --version
> ```

---

## Step 1: Create a folder for your project
mkdir ~/OSS-Project-Rishi && cd ~/OSS-Project-Rishi

## Step 2: Create each script file (paste each script's content into nano, then Ctrl+O to save, Ctrl+X to exit)
nano script1_system_identity.sh
nano script2_package_inspector.sh
nano script3_disk_auditor.sh
nano script4_log_analyzer.sh
nano script5_manifesto.sh

## Step 3: Make all scripts executable
chmod +x script1_system_identity.sh script2_package_inspector.sh script3_disk_auditor.sh script4_log_analyzer.sh script5_manifesto.sh

## Step 4: Install LibreOffice (needed for Script 2)
sudo apt update && sudo apt install libreoffice -y

## Step 5: Run each script
./script1_system_identity.sh
./script2_package_inspector.sh
./script3_disk_auditor.sh
./script4_log_analyzer.sh        # auto-generates sample log
./script5_manifesto.sh           # will ask you 3 questions

## Step 6 — Install Apache (Required for Scripts 2, 3, 4)

**Ubuntu / Debian:**
```bash
sudo apt update
sudo apt install apache2 -y
```

**CentOS / RHEL / Fedora:**
```bash
sudo dnf install httpd -y
```

**Verify Apache is installed:**
```bash
# Ubuntu/Debian
apache2 -v

# CentOS/RHEL
httpd -v
```

**Start the Apache service:**
```bash
# Ubuntu/Debian
sudo systemctl start apache2
sudo systemctl enable apache2

# CentOS/RHEL
sudo systemctl start httpd
sudo systemctl enable httpd
```

**Check Apache is running:**
```bash
sudo systemctl status apache2
# or
sudo systemctl status httpd
```

---

## Running the Scripts

---

### Script 1 — System Identity Report

**What it does:**
Displays a formatted welcome screen showing your Linux distribution name, kernel version, currently logged-in user, home directory, system uptime, current date and time, and the open-source license of the Linux kernel (GPL v2).

**How to run:**
```bash
bash script1_system_identity.sh
```

**Expected output:**
```
==============================================
   Open Source Audit — [Your Name]
   Auditing: Apache HTTP Server
==============================================

  Linux Distribution : Ubuntu 22.04.3 LTS
  Kernel Version     : 5.15.0-91-generic
  Logged-in User     : youruser
  Home Directory     : /home/youruser
  System Uptime      : up 2 hours, 14 minutes
  Current Date/Time  : 30 March 2026, 14:32:07

----------------------------------------------
  OS License Notice
----------------------------------------------
  The Linux kernel running this system is
  licensed under the GNU General Public
  License version 2 (GPL v2).
==============================================
```

**Shell concepts used:** Variables, `echo`, command substitution `$()`, `uname`, `whoami`, `uptime -p`, `date`, `grep`, `cut`, `tr`

---

### Script 2 — FOSS Package Inspector

**What it does:**
Detects whether you are on a Debian-based or RPM-based system, checks if Apache is installed, prints its version and license details, and uses a `case` statement to display an open-source philosophy note about the package.

**How to run:**
```bash
bash script2_package_inspector.sh
```

**If you want to test it with a different package** (optional), open the script and change the `PACKAGE` variable on line 17:
```bash
# For Ubuntu/Debian
PACKAGE="apache2"

# For CentOS/RHEL/Fedora
PACKAGE="httpd"
```

**Expected output (if Apache is installed):**
```
==============================================
  FOSS Package Inspector
==============================================

  Package Manager Detected: dpkg

  STATUS: apache2 is INSTALLED on this system.

  --- Package Details ---
  Version: 2.4.52-1ubuntu4.7
  Homepage: https://httpd.apache.org

----------------------------------------------
  Open Source Philosophy Notes
----------------------------------------------
  Apache HTTP Server:
  Licensed under Apache License 2.0.
  Powers ~30% of all websites globally.
==============================================
```

**Shell concepts used:** `if-then-else`, `case` statement, `dpkg` / `rpm`, `grep -E`, `command -v`, exit code `$?`

---

### Script 3 — Disk and Permission Auditor

**What it does:**
Loops through five standard Linux system directories (`/etc`, `/var/log`, `/home`, `/usr/bin`, `/tmp`) and reports permissions, owner, and disk usage for each. Then separately checks all standard Apache installation directories and reports which ones exist on your system.

**How to run:**
```bash
bash script3_disk_permission_auditor.sh
```

> No sudo needed. The script uses `2>/dev/null` to silently skip directories it cannot measure.

**Expected output:**
```
==============================================
  Disk and Permission Auditor
==============================================

  --- Standard System Directory Audit ---

  Directory : /etc
  Perms/Owner: drwxr-xr-x root root
  Size      : 12M
  ----------------------------------------------
  Directory : /var/log
  Perms/Owner: drwxrwxr-x root syslog
  Size      : 45M
  ----------------------------------------------
  ...

  --- Apache HTTP Server Directory Audit ---

  [FOUND] /etc/apache2
  Perms/Owner: drwxr-xr-x root root
  Size      : 136K
  ----------------------------------------------
  [FOUND] /var/www/html
  Perms/Owner: drwxr-xr-x root root
  Size      : 4.0K
  ----------------------------------------------
```

**Shell concepts used:** `for` loop, arrays `"${DIRS[@]}"`, `ls -ld`, `du -sh`, `awk`, `cut`, `-d` directory test, `-e` existence test, arithmetic `$((FOUND + 1))`

---

### Script 4 — Log File Analyzer

**What it does:**
Reads an Apache log file line by line, counts how many lines contain a given keyword (default: `error`), and prints the last 5 matching lines. Includes a retry prompt if the file is not found, and an empty-file warning.

**How to run:**

Basic usage — scan Apache error log for the word "error":
```bash
bash script4_log_analyzer.sh /var/log/apache2/error.log
```

Scan with a custom keyword:
```bash
bash script4_log_analyzer.sh /var/log/apache2/error.log warn
```

Scan the access log for GET requests:
```bash
bash script4_log_analyzer.sh /var/log/apache2/access.log GET
```

**CentOS/RHEL log paths:**
```bash
bash script4_log_analyzer.sh /var/log/httpd/error_log error
bash script4_log_analyzer.sh /var/log/httpd/access_log GET
```

> If Apache has just been installed and no requests have been made yet, the log files may be empty. Make a test request first:
> ```bash
> curl http://localhost
> ```
> Then re-run the script.

**Expected output:**
```
==============================================
  Apache Log File Analyzer
==============================================

  Log File : /var/log/apache2/error.log
  Keyword  : 'error' (case-insensitive)

  Scanning...

----------------------------------------------
  SCAN RESULTS
----------------------------------------------
  Keyword 'error' found 3 time(s) in:
  /var/log/apache2/error.log

  --- Last 5 Matching Lines ---

  [Match 1] [Mon Mar 30 14:12:01.343619 2026] [core:error] ...
```

**Shell concepts used:** `while IFS= read -r`, `if-then`, counter variables, command-line arguments `$1 $2`, default values `${2:-"error"}`, array indexing, arithmetic expansion

---

### Script 5 — Open Source Manifesto Generator

**What it does:**
Asks you three interactive questions, then composes a personalised open-source philosophy paragraph using your answers. Saves the output to a file called `manifesto_[yourusername].txt` and prints it to the screen.

**How to run:**
```bash
bash script5_manifesto_generator.sh
```

The script will prompt you interactively:
```
  Answer three questions below.

  1. Name one open-source tool you use every day: git
  2. In one word, what does 'freedom' mean to you?: choice
  3. Name one thing you would build and share freely: a study app
```

**Output file location:**
The manifesto is saved in the same directory where you run the script:
```bash
cat manifesto_$(whoami).txt
```

**Shell concepts used:** `read -p`, string concatenation with variables, `>` (create/overwrite) and `>>` (append) file redirection, `date`, `$(whoami)`, `-z` empty string test, alias concept (documented in script comments)

---

## Troubleshooting

| Problem | Fix |
|---|---|
| `Permission denied` when running a script | Run `chmod +x scriptname.sh` first |
| `apache2: command not found` | Install Apache: `sudo apt install apache2` |
| Script 4 says log file not found | Run `curl http://localhost` to generate a log entry, then retry |
| Script 2 shows "NOT installed" | Apache package name differs by distro — change `PACKAGE="apache2"` to `PACKAGE="httpd"` inside the script |
| `bad interpreter: No such file or directory` | Your script has Windows line endings. Fix with: `sed -i 's/\r//' scriptname.sh` |
| Running on CentOS and dpkg not found | The script auto-detects your package manager. If it fails, ensure `rpm` is available: `which rpm` |

---

## Verifying Everything Works (Quick Test)

Run all 5 scripts back to back:

```bash
bash script1_system_identity.sh
bash script2_package_inspector.sh
bash script3_disk_permission_auditor.sh
bash script4_log_analyzer.sh /var/log/apache2/error.log error
bash script5_manifesto_generator.sh
```

---

## Apache Key Commands Reference

```bash
# Start / Stop / Restart
sudo systemctl start apache2
sudo systemctl stop apache2
sudo systemctl restart apache2

# Check status
sudo systemctl status apache2

# Enable on boot
sudo systemctl enable apache2

# Test config file for syntax errors
sudo apache2ctl configtest

# View live error log
sudo tail -f /var/log/apache2/error.log

# View live access log
sudo tail -f /var/log/apache2/access.log

# Check Apache version
apache2 -v

# List loaded modules
apache2ctl -M
```

---

*Submitted as part of the Open Source Software (NGMC) Capstone Project.*
