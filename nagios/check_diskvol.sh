#!/bin/bash
#
# alert when disk volume over threshold
#
#  usage : check_diskvol.sh -c threshold
#                                  by alex
##################################################

STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3

while getopts "c:" optname;do
    case "$optname" in
      "c")
        THRESHOLD=$OPTARG
        ;;
      *)
      # Should not occur
        echo "Unknown error while processing options"
        ;;
    esac
done

output=`df |awk 'NR!=1{split($5,myarr,"%");if(myarr[1]>'$THRESHOLD'){print $1" i                                                                                                 s : "myarr[1]}}'`

if [ "$output" = "" ];then
echo "OK - volume is under water mark $THRESHOLD%"
exit $STATE_OK
else
echo -e "CRITICAL - volume is above $THRESHOLD% \n$output"
exit $STATE_CRITICAL
fi

