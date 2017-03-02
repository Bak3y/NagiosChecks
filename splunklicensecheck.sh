#!/bin/sh
declare -i used_bytes
declare -i warn
declare -i crit
pool=$1
warn=$2
crit=$3

used_bytes="$(curl -s -k -u admin:password https://splunklicenseserver.domain.com:8089/servicesNS/nobody/system/licenser/pools/$pool | grep used_bytes | grep -Eo '[0-9]+')"

UsedGB="$((used_bytes /1073741824 ))"

if (( $UsedGB < $warn )) ;
	then echo "Status returned Normal, $UsedGB GB less than $warn GB in $pool|license_usage=$UsedGB;$warn;$crit;;;" && exit 0;
elif (( $UsedGB > $warn && $UsedGB < $crit )) ; 
	then echo "Status returned Warning, $UsedGB GB between $warn and $crit in $pool|license_usage=$UsedGB;$warn;$crit;;;" && exit 1;
elif (( $UsedGB > $crit )) ;
	then echo "Status returned Critical, $UsedGB GB greater than $crit in $pool|license_usage=$UsedGB;$warn;$crit;;;" && exit 2;
else echo "Unknown Response" && exit 3; fi
