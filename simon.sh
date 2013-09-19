#!/bin/sh
#
# Simple sys monitoring script
#

LANG=C

# Change this .. 
LA_HIGH=5
MAIL=my@email
HOST=my.host
LOG_PATH=/var/log/simon
DELIM=`/usr/bin/env perl -e 'print "-" x 100,"\n";'`

[ -d "$LOG_PATH" ] || mkdir $LOG_PATH

while :; do

LA=`cat /proc/loadavg | cut -f 1 -d .`

if [ $LA -gt $LA_HIGH ]
then    
        
        echo "Load average in $HOST more than $LA_HIGH" | mail -s "Big LA on $HOST" $MAIL      

        /bin/date >> $LOG_PATH/top.log
        /usr/bin/top -n 1 -b >> $LOG_PATH/top.log
        $DELIM >> $LOG_PATH/top.log

        /bin/date >> $LOG_PATH/full_status.log
        /opt/simon/run_full_status.sh >> $LOG_PATH/full_status.log
        $DELIM >> $LOG_PATH/full_status.log

        /bin/date >> $LOG_PATH/mysql_ps_list.log
        /opt/simon/mysql_ps_list.sh >> $LOG_PATH/mysql_ps_list.log
        $DELIM >> $LOG_PATH/mysql_ps_list.log

        /bin/date >> $LOG_PATH/server_status.log
        /opt/simon/run_status_apache2.sh >> $LOG_PATH/server_status.log
        $DELIM >> $LOG_PATH/server_status.log

        /bin/date >> $LOG_PATH/ps.log
        /bin/ps auxwwf >> $LOG_PATH/ps.log
        $DELIM >> $LOG_PATH/ps.log

        /bin/date >> $LOG_PATH/vmstat.log
        /usr/bin/vmstat 2 3 >> $LOG_PATH/vmstat.log
        $DELIM >> $LOG_PATH/vmstat.log
fi

sleep 20

done
