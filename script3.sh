#!/bin/bash
# ============================================================
# Script 3: Disk and Permission Auditor
# Author: [Your Name] | Roll No: [Your Roll Number]
# Course: Open Source Software | Chosen Software: Apache HTTP Server
# Description: Loops through key system directories and reports
#              permissions, owner, and disk usage for each.
#              Also checks Apache-specific config directories.
# ============================================================

# --- List of standard system directories to audit ---
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp")

echo "=============================================="
echo "  Disk and Permission Auditor"
echo "=============================================="
echo ""
echo "  --- Standard System Directory Audit ---"
echo ""

# --- for loop: Iterate over each directory in the DIRS array ---
for DIR in "${DIRS[@]}"; do

    # Check if the directory actually exists before trying to inspect it
    if [ -d "$DIR" ]; then

        # ls -ld lists the directory itself (not its contents)
        # awk '{print $1, $3, $4}' extracts: permissions, owner-user, owner-group
        PERMS=$(ls -ld "$DIR" | awk '{print $1, $3, $4}')

        # du -sh gives human-readable size of the directory
        # 2>/dev/null suppresses permission-denied errors
        # cut -f1 takes only the size column (before the tab)
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)

        echo "  Directory : $DIR"
        echo "  Perms/Owner: $PERMS"
        echo "  Size      : $SIZE"
        echo "  ----------------------------------------------"
    else
        echo "  $DIR does NOT exist on this system."
        echo "  ----------------------------------------------"
    fi
done

echo ""
echo "  --- Apache HTTP Server Directory Audit ---"
echo ""

# Apache-specific directories to check
# These paths are standard on Debian/Ubuntu (apache2)
# On CentOS/RHEL: config is /etc/httpd, logs at /var/log/httpd
APACHE_DIRS=(
    "/etc/apache2"          # Main Apache config directory (Debian/Ubuntu)
    "/etc/httpd"            # Main Apache config directory (RHEL/CentOS)
    "/var/log/apache2"      # Apache log files (Debian/Ubuntu)
    "/var/log/httpd"        # Apache log files (RHEL/CentOS)
    "/var/www/html"         # Default web document root
    "/usr/sbin/apache2"     # Apache binary (Debian/Ubuntu)
    "/usr/sbin/httpd"       # Apache binary (RHEL/CentOS)
)

# Counter to track how many Apache directories were found
FOUND=0

# Loop through Apache-specific directories
for ADIR in "${APACHE_DIRS[@]}"; do

    # Check if this path exists (as a file OR directory)
    if [ -e "$ADIR" ]; then
        FOUND=$((FOUND + 1))   # Increment counter using arithmetic expansion

        # ls -ld works for both files and directories
        APERMS=$(ls -ld "$ADIR" | awk '{print $1, $3, $4}')
        ASIZE=$(du -sh "$ADIR" 2>/dev/null | cut -f1)

        echo "  [FOUND] $ADIR"
        echo "  Perms/Owner: $APERMS"
        echo "  Size      : $ASIZE"
        echo "  ----------------------------------------------"
    fi
done

# Inform the user if no Apache directories were found at all
if [ $FOUND -eq 0 ]; then
    echo "  No Apache directories found."
    echo "  Apache may not be installed on this system."
    echo "  Install with: sudo apt install apache2"
    echo "            or: sudo dnf install httpd"
fi

echo ""
echo "  Audit complete."
echo "=============================================="