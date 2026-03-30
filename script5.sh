#!/bin/bash
# ============================================================
# Script 5: Open Source Manifesto Generator
# Author: [Your Name] | Roll No: [Your Roll Number]
# Course: Open Source Software | Chosen Software: Apache HTTP Server
# Description: Asks the user three interactive questions and
#              composes a personalised open-source philosophy
#              statement, saving it to a .txt file.
# ============================================================

# --- Alias concept (demonstrated via comment) ---
# In a real shell session, you might define an alias like:
#   alias makemanifesto='bash script5_manifesto_generator.sh'
# This would let you run the script by just typing: makemanifesto
# Aliases are session-level shortcuts — they live in ~/.bashrc
# We don't define the alias inside the script (it wouldn't persist),
# but we document the concept here as required.

echo "=============================================="
echo "  Open Source Manifesto Generator"
echo "  Inspired by: Apache HTTP Server"
echo "=============================================="
echo ""
echo "  Answer three questions below."
echo "  Your answers will be woven into a personal"
echo "  open-source philosophy statement."
echo ""

# --- read: Prompt user for interactive input ---
# -p flag lets us put the prompt on the same line as the cursor
read -p "  1. Name one open-source tool you use every day: " TOOL
echo ""

read -p "  2. In one word, what does 'freedom' mean to you?: " FREEDOM
echo ""

read -p "  3. Name one thing you would build and share freely: " BUILD
echo ""

# --- Validate that the user actually entered something ---
# -z checks if a string is empty
if [ -z "$TOOL" ] || [ -z "$FREEDOM" ] || [ -z "$BUILD" ]; then
    echo "  ERROR: All three answers are required."
    echo "  Please re-run the script and provide all inputs."
    exit 1
fi

# --- Date and output filename ---
DATE=$(date '+%d %B %Y')               # e.g. 15 June 2025
TIME=$(date '+%H:%M:%S')               # e.g. 14:32:07
OUTPUT="manifesto_$(whoami).txt"       # Filename includes the current user's name

echo ""
echo "  Generating your manifesto..."
echo ""

# --- String concatenation: Build the manifesto paragraph ---
# Each echo >> appends a new line to the output file
# > would overwrite; >> appends — we use > for the first line, >> for rest

# First line: overwrite (create/reset) the file
echo "=============================================" > "$OUTPUT"

# Append the rest of the manifesto using >>
echo "  OPEN SOURCE MANIFESTO" >> "$OUTPUT"
echo "  Generated on: $DATE at $TIME" >> "$OUTPUT"
echo "  Author: $(whoami)" >> "$OUTPUT"
echo "=============================================" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# The manifesto paragraph uses string concatenation — the variables
# $TOOL, $FREEDOM, and $BUILD are embedded directly into the text
echo "  Every day, I rely on $TOOL — a tool I did not pay" >> "$OUTPUT"
echo "  for, did not ask permission to use, and can study" >> "$OUTPUT"
echo "  down to its last line of code. To me, freedom means" >> "$OUTPUT"
echo "  $FREEDOM. That is what open source gives the world:" >> "$OUTPUT"
echo "  not just free software, but the freedom to understand," >> "$OUTPUT"
echo "  improve, and share the tools we all depend on." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  One day, I want to build $BUILD and release it" >> "$OUTPUT"
echo "  openly — because knowledge grows when it is shared," >> "$OUTPUT"
echo "  and the most powerful thing a developer can do is" >> "$OUTPUT"
echo "  make someone else's work a little easier." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  Apache HTTP Server stands as proof of this: built" >> "$OUTPUT"
echo "  freely, shared freely, and trusted to serve a third" >> "$OUTPUT"
echo "  of the entire internet. That is what open source" >> "$OUTPUT"
echo "  looks like when a community chooses transparency" >> "$OUTPUT"
echo "  over profit." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  — Written under the values of the Apache License 2.0" >> "$OUTPUT"
echo "=============================================" >> "$OUTPUT"

# Confirm to the user that the file was created
echo "  Manifesto saved to: $OUTPUT"
echo ""
echo "----------------------------------------------"

# Display the saved file using cat
cat "$OUTPUT"

echo ""
echo "=============================================="
echo "  Done. Your manifesto is ready to submit."
echo "=============================================="