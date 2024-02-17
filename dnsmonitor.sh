#!/bin/sh

# Changed egrep to grep -E

#          name: merlin-dns-monitor.sh
#       version: 1.4.2, 26-apr-2022, by eibgrad
#       purpose: monitor what dns servers are active and where routed
# ... (other script content) ...

# Function or script segment dealing with DNS monitoring
# This part shows the corrected use of grep -E instead of egrep
[ ${sw_dupes+x} ] && _print_with_dupe_count || uniq $DATA

# publish Do53/DoT over tcp (replied and sorted)
grep -E '^ipv4 .* tcp .* dport=(53|853) ' /proc/net/nf_conntrack | \
    awk '/ASSURED/{printf "%s %-19s %-19s %-9s %-19s %s\n",
            $3, $7, $8, $10, $11, $12}' | \
        sort > $DATA

# More script content...
# Example of corrected conditional checks using grep -E
if echo $line | grep 'dport=53 ' | \
        grep -qE "(src|dst)=($wan0_ip|$wan1_ip)( |$)"; then
    # Do53 connection routed over WAN
    printf "${sev_lvl_2}$line_4disp${RS}\n"
elif echo $line | grep 'dport=853 ' | \
        grep -qE "(src|dst)=($wan0_ip|$wan1_ip)( |$)"; then
    # DoT connection routed over WAN
    printf "${sev_lvl_1}$line_4disp${RS}\n"
fi
# ... (remaining script content) ...
