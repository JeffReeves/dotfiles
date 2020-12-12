#!/bin/bash
# purpose: Retrieves general stats such as:
#   - hostname
#   - uptime
#   - free      (top 10 memory consumers)
#   - df        (filesystems sorted by name)
#   - du        (top 10 largest directories)
#   - who
#   - last      (last 10 users/events)

# get values
HOSTNAME=$(hostname)
UPTIME=$(uptime)
MEMORY_TOP10=$(ps aux --sort -rss --width 130 | head)
FILESYSTEMS=$(df -h | grep -vE '/dev/loop|tmpfs|udev' | sort -k1 -V)
DIRECTORY_TOP10=$(du --threshold=4M -Shx / | sort -hr | head -n10)
LAST=$(last | tail -n12)