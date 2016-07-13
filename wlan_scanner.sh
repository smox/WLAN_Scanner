#!/bin/bash

COUNT=10;
WLAN_ADAPTER='wlan0';
STRENGTH=0;


usage()
{
    cat << EOF
    usage:
       Connect to the Wifi network you want to test
       For a standard test, no options are necessary
     

    OPTIONS:
        -h      Show this message
        -a      WLAN Adapter name (default: wlan0)
        -c      Number of measurements (default 10
EOF
}

while getopts "hc:" OPTION
do
    case $OPTION in
        h)
            usage
            exit 1
            ;;
        c)
            COUNT=$OPTARG
            ;;
        ?)
            usage
            exit 1
            ;;
    esac
done

for((i=0;i<$COUNT;i++))
do
    STRENGTH=$(($STRENGTH+$(iwconfig $WLAN_ADAPTER | grep 'Signal level='|awk -F'=' '{ print $2 }' | awk -F'/' '{ print $1 }')));
    echo "Meassurement: "$((i+1));
    sleep 1;
done
QUALITY=$(( STRENGTH / COUNT  ));
echo "Average quality of "$WLAN_ADAPTER": "$QUALITY;
