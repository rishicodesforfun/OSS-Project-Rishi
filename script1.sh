#!/bin/bash
# ============================================================
# Script 1: System Identity Report
# Author: [Your Name] | Roll No: [Your Roll Number]
# Course: Open Source Software | Chosen Software: Apache HTTP Server
# Description: Displays a welcome screen with key system info
#              and the open-source license of the OS.
# ============================================================

# --- Variables ---
STUDENT_NAME="Rishi Raj"         # Replace with your actual name
SOFTWARE_CHOICE="Apache HTTP Server"  # Chosen OSS project

# --- Gather system information using command substitution $() ---
KERNEL=$(uname -r)                            # Linux kernel version
USER_NAME=$(whoami)                           # Currently logged-in user
HOME_DIR=$HOME                                # Home directory of current user
UPTIME=$(uptime -p)                           # Human-readable uptime
CURRENT_DATE=$(date '+%d %B %Y, %H:%M:%S')   # Formatted current date and time

# Get the Linux distribution name from /etc/os-release file
# The 'grep' finds the PRETTY_NAME line, 'cut' extracts the value after '='
# 'tr -d' removes surrounding quotes from the value
DISTRO=$(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')

# --- Display the report as a formatted welcome screen ---
echo "=============================================="
echo "   Open Source Audit — $STUDENT_NAME"
echo "   Auditing: $SOFTWARE_CHOICE"
echo "=============================================="
echo ""
echo "  Linux Distribution : $DISTRO"
echo "  Kernel Version     : $KERNEL"
echo "  Logged-in User     : $USER_NAME"
echo "  Home Directory     : $HOME_DIR"
echo "  System Uptime      : $UPTIME"
echo "  Current Date/Time  : $CURRENT_DATE"
echo ""
echo "----------------------------------------------"
echo "  OS License Notice"
echo "----------------------------------------------"
# The Linux kernel (which powers this OS) is licensed under GPL v2.
# GPL v2 (GNU General Public License version 2) grants users the freedom
# to run, study, modify, and redistribute the software, provided that
# any modified versions are also distributed under the same GPL v2 terms.
echo "  The Linux kernel running this system is"
echo "  licensed under the GNU General Public"
echo "  License version 2 (GPL v2)."
echo ""
echo "  GPL v2 guarantees: freedom to run, study,"
echo "  modify, and share this OS and its source."
echo "=============================================="