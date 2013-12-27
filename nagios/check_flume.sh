#!/bin/bash
#
# monitor log info ,if get error info alert me
#
# INTERVAL : min which need look ahead
# FIELD : which field text we monitor
# DATEFORMAT : log date format
# TGT : the log we monitor
# ALERTWORD : monitor alert text
# WARNINGWORD : monitor warning text
#
#                                          write by alex
############################################################

STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3

INTERVAL=60
FIELD=6
DATEFORMAT="+%b %d %H:%M"
TGT="/var/log/messages"
ALERTWORD=mytest
WARNINGWORD=ok

#DATEFORMAT="+%d %b %Y %H:%M"
NOW=`date '+%d %b %Y %T'`
#START= `date '+%d %b %Y %H:%M' -d '5 min ago'`
START=`date "$DATEFORMAT" -d "$INTERVAL min ago"`
#ALERTWORD=ERROR
#WARNINGWORD=WARN
ALERT=
WARNING=

echo now is $NOW and start is $START

#awk '/^'"$START"'/,0{print \$'"$FIELD"'}' $TGT

eval $(awk '/^'"$START"'/,0{if($'"$FIELD"'=="'$ALERTWORD'"){print "ALERT=YES"}if($'"$FIELD"'=="'$WARNINGWORD'"){print "WARNING=YES"}}' $TGT)

echo $ALERT " : " $WARNING


if [ "$ALERT" = "YES" ];then
echo "CRITICAL - flume log error message in last $INTERVAL min"
exit $STATE_CRITICAL
elif [ "$WARNING" = "YES" ];then
echo "WARNING - flume log warning message in last $INTERVAL min"
exit $STATE_WARNING
else
echo "OK - flume log is ok in last $INTERVAL min"
exit $STATE_OK
fi
:<<\EOF
EOF

