#!/bin/bash
# ============================================================
# Script 2: FOSS Package Inspector
# Author: [Your Name] | Roll No: [Your Roll Number]
# Course: Open Source Software | Chosen Software: Apache HTTP Server
# Description: Checks if a FOSS package is installed, shows its
#              version/license, and prints a philosophy note
#              about it using a case statement.
# ============================================================

# --- Package to inspect ---
# Apache HTTP Server is called 'apache2' on Debian/Ubuntu
# and 'httpd' on RHEL/CentOS/Fedora systems
PACKAGE="apache2"   # Change to 'httpd' if you are on CentOS/RHEL/Fedora

echo "=============================================="
echo "  FOSS Package Inspector"
echo "=============================================="
echo ""

# --- Detect the package manager available on this system ---
# This makes the script work on both Debian-based and RPM-based distros
if command -v dpkg &>/dev/null; then
    PKG_MANAGER="dpkg"   # Debian / Ubuntu
elif command -v rpm &>/dev/null; then
    PKG_MANAGER="rpm"    # RHEL / CentOS / Fedora
else
    echo "ERROR: No recognised package manager (dpkg or rpm) found."
    exit 1
fi

echo "  Package Manager Detected: $PKG_MANAGER"
echo ""

# --- if-then-else: Check whether the package is installed ---
if [ "$PKG_MANAGER" = "dpkg" ]; then
    # dpkg -l lists packages; grep searches for our package name
    # &>/dev/null suppresses output — we only care about exit status (0 = found)
    dpkg -l "$PACKAGE" &>/dev/null
    INSTALLED=$?   # $? holds exit code of last command (0 = success)
else
    rpm -q "$PACKAGE" &>/dev/null
    INSTALLED=$?
fi

if [ $INSTALLED -eq 0 ]; then
    echo "  STATUS: $PACKAGE is INSTALLED on this system."
    echo ""
    echo "  --- Package Details ---"

    # Extract and display Version, License, and Summary fields
    if [ "$PKG_MANAGER" = "dpkg" ]; then
        # dpkg-query gives detailed info; grep with -E allows multiple patterns
        dpkg-query -s "$PACKAGE" | grep -E 'Version|Homepage|Description'
    else
        rpm -qi "$PACKAGE" | grep -E 'Version|License|Summary'
    fi
else
    echo "  STATUS: $PACKAGE is NOT installed on this system."
    echo ""
    echo "  To install Apache on Ubuntu/Debian, run:"
    echo "    sudo apt update && sudo apt install apache2"
    echo ""
    echo "  To install Apache on CentOS/RHEL/Fedora, run:"
    echo "    sudo dnf install httpd"
fi

echo ""
echo "----------------------------------------------"
echo "  Open Source Philosophy Notes"
echo "----------------------------------------------"

# --- case statement: Print a philosophy note for each known FOSS package ---
# The case statement matches the value of $PACKAGE against several patterns
case $PACKAGE in
    apache2 | httpd)
        echo "  Apache HTTP Server:"
        echo "  Licensed under Apache License 2.0."
        echo "  Powers ~30% of all websites globally."
        echo "  It proved that collaborative, open development"
        echo "  could outperform commercial software at scale."
        ;;
    mysql | mariadb)
        echo "  MySQL / MariaDB:"
        echo "  A dual-licensed database (GPL v2 + Commercial)."
        echo "  MariaDB was forked from MySQL by the original"
        echo "  creator after Oracle acquired Sun Microsystems —"
        echo "  a real-world example of forking to preserve freedom."
        ;;
    firefox)
        echo "  Mozilla Firefox:"
        echo "  Licensed under MPL 2.0."
        echo "  A nonprofit browser built to keep the web open."
        echo "  Exists to prevent any single company from"
        echo "  controlling how the internet is experienced."
        ;;
    vlc)
        echo "  VLC Media Player:"
        echo "  Licensed under LGPL/GPL."
        echo "  Started by students at École Centrale Paris."
        echo "  Plays virtually every media format — built freely,"
        echo "  shared freely, used by hundreds of millions."
        ;;
    python3 | python)
        echo "  Python:"
        echo "  Licensed under PSF License."
        echo "  Shaped entirely by community consensus."
        echo "  Demonstrates how open governance can produce"
        echo "  a language trusted by science, education, and industry."
        ;;
    git)
        echo "  Git:"
        echo "  Licensed under GPL v2."
        echo "  Created by Linus Torvalds in 2005 when the"
        echo "  proprietary BitKeeper license was revoked."
        echo "  Now the backbone of nearly all software development."
        ;;
    *)
        # Default case for any unrecognised package
        echo "  $PACKAGE: An open-source tool that embodies"
        echo "  the principle that knowledge shared is knowledge"
        echo "  multiplied. Freedom to study and modify makes"
        echo "  software safer and more trustworthy for everyone."
        ;;
esac

echo "=============================================="