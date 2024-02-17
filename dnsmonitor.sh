# diff /mnt/TOSHIBA2/ASUS/merlin-dns-monitor.sh ./dnsmonitor.sh
--- /mnt/TOSHIBA2/ASUS/merlin-dns-monitor.sh
+++ ./dnsmonitor.sh
@@ -1,5 +1,7 @@
 #!/bin/sh

+# Changed egrep to grep -E
+
 #          name: merlin-dns-monitor.sh
 #       version: 1.4.2, 26-apr-2022, by eibgrad
 #       purpose: monitor what dns servers are active and where routed
@@ -200,7 +202,7 @@
     [ ${sw_dupes+x} ] && _print_with_dupe_count || uniq $DATA

     # publish Do53/DoT over tcp (replied and sorted)
-    egrep '^ipv4 .* tcp .* dport=(53|853) ' /proc/net/nf_conntrack | \
+    grep -E '^ipv4 .* tcp .* dport=(53|853) ' /proc/net/nf_conntrack | \
         awk '/ASSURED/{printf "%s %-19s %-19s %-9s %-19s %s\n",
                 $3, $7, $8, $10, $11, $12}' | \
             sort > $DATA
@@ -328,7 +330,7 @@
     fi

     if echo $line | grep 'dport=53 ' | \
-            egrep -q "(src|dst)=($wan0_ip|$wan1_ip)( |$)"; then
+            grep -qE "(src|dst)=($wan0_ip|$wan1_ip)( |$)"; then
         # Do53 connection routed over WAN
         printf "${sev_lvl_2}$line_4disp${RS}\n"

@@ -340,7 +342,7 @@
             grep -qxF "$line" $LOG || echo "$line" >> $LOG
         fi
     elif echo $line | grep 'dport=853 ' | \
-            egrep -q "(src|dst)=($wan0_ip|$wan1_ip)( |$)"; then
+            grep -qE "(src|dst)=($wan0_ip|$wan1_ip)( |$)"; then
         # DoT connection routed over WAN
         printf "${sev_lvl_1}$line_4disp${RS}\n"
     else
