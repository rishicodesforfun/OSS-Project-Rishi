#!/bin/bash
# ============================================================
# Script 4: Log File Analyzer
# Author: [Your Name] | Roll No: [Your Roll Number]
# Course: Open Source Software | Chosen Software: Apache HTTP Server
# Description: Reads a log file line by line, counts occurrences
#              of a keyword, and prints matching lines.
#              Designed to work with Apache access/error logs.
# Usage: ./script4_log_analyzer.sh /var/log/apache2/error.log [keyword]
# ============================================================

# $1 is the first command-line argument — the log file path
LOGFILE=$1

# $2 is the optional second argument — keyword to search for
# If not provided, default to "error" using the := default syntax
KEYWORD=${2:-"error"}

# Counter variable to track how many matching lines are found
COUNT=0

# Array to store last 5 matching lines for display at the end
LAST_MATCHES=()

echo "=============================================="
echo "  Apache Log File Analyzer"
echo "=============================================="
echo ""

# --- Input validation: Check if the user provided a file path ---
if [ -z "$LOGFILE" ]; then
    echo "  ERROR: No log file specified."
    echo ""
    echo "  Usage: $0 <logfile> [keyword]"
    echo ""
    echo "  Apache log file locations:"
    echo "    Ubuntu/Debian : /var/log/apache2/error.log"
    echo "                    /var/log/apache2/access.log"
    echo "    CentOS/RHEL   : /var/log/httpd/error_log"
    echo "                    /var/log/httpd/access_log"
    exit 1
fi

# --- Check if the specified file actually exists ---
if [ ! -f "$LOGFILE" ]; then
    echo "  ERROR: File '$LOGFILE' not found."
    echo ""

    # Do-while style retry: ask the user to try a fallback log path
    # This mimics a retry loop — bash doesn't have do-while natively,
    # but we simulate it with a while loop that runs at least once
    RETRY=1
    while [ $RETRY -eq 1 ]; do
        echo "  Would you like to try the default Apache log path?"
        echo "  Press Enter to try /var/log/apache2/error.log, or type 'n' to exit:"
        read -r USER_INPUT

        if [ "$USER_INPUT" = "n" ]; then
            echo "  Exiting. Please provide a valid log file path."
            exit 1
        else
            # Try the default fallback path
            FALLBACK="/var/log/apache2/error.log"
            if [ -f "$FALLBACK" ]; then
                echo "  Using fallback: $FALLBACK"
                LOGFILE="$FALLBACK"
                RETRY=0   # Exit the retry loop
            else
                # Fallback also not found — stop retrying
                echo "  Fallback log not found either. Is Apache installed?"
                echo "  Install with: sudo apt install apache2"
                exit 1
            fi
        fi
    done
fi

# --- Check if the file is empty ---
if [ ! -s "$LOGFILE" ]; then
    echo "  WARNING: Log file '$LOGFILE' is empty."
    echo "  Apache may not have written any entries yet."
    echo "  Try accessing your web server and re-run this script."
    exit 0
fi

echo "  Log File : $LOGFILE"
echo "  Keyword  : '$KEYWORD' (case-insensitive)"
echo ""
echo "  Scanning..."
echo ""

# --- while read loop: Read the log file one line at a time ---
# IFS= prevents leading/trailing whitespace from being stripped
# -r prevents backslash interpretation (raw mode)
while IFS= read -r LINE; do

    # if-then: Check if this line contains the keyword (case-insensitive)
    # grep -i = case insensitive, -q = quiet (no output, just exit code)
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))   # Increment counter with arithmetic expansion

        # Store in LAST_MATCHES array (keeps growing, we'll use tail logic below)
        LAST_MATCHES+=("$LINE")
    fi

done < "$LOGFILE"   # Redirect the file into the while loop as input

# --- Display results ---
echo "----------------------------------------------"
echo "  SCAN RESULTS"
echo "----------------------------------------------"
echo "  Keyword '$KEYWORD' found $COUNT time(s) in:"
echo "  $LOGFILE"
echo ""

# Show the last 5 matching lines if any were found
if [ $COUNT -gt 0 ]; then
    echo "  --- Last 5 Matching Lines ---"
    echo ""

    # Calculate starting index to get the last 5 entries from the array
    TOTAL=${#LAST_MATCHES[@]}   # Total number of matching lines

    # If fewer than 5 matches, start from 0; otherwise start from (total - 5)
    if [ $TOTAL -le 5 ]; then
        START=0
    else
        START=$((TOTAL - 5))
    fi

    # Loop from START to end of array and print each line
    for (( i=START; i<TOTAL; i++ )); do
        echo "  [Match $((i+1))] ${LAST_MATCHES[$i]}"
        echo ""
    done
else
    echo "  No lines containing '$KEYWORD' were found."
    echo "  Try a different keyword like 'warn', 'crit', or 'GET'."
fi

echo "=============================================="