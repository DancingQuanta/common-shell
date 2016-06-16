#!/bin/sh
# Personalised message of the day MOTD
# Source from /home/pi/.bash_profile

clear # Clear the console

## Date and time
DATETIME=`date +"%A, %e %B %Y, %r"`

## System
SYSTEM=`uname -srmo`

## Calculate last login
ME=$(whoami)
if which last &> /dev/null; then
	LASTLOG=($(last -n2 $ME));
	FROM=${LASTLOG[13]};
	DAY=${LASTLOG[14]};
	MONTH=${LASTLOG[15]};
	NOOFDAY=${LASTLOG[16]};
	TIME=${LASTLOG[17]};
	LOGIN="$DAY $MONTH $NOOFDAY $TIME from $FROM"
else
	LOGIN="N/A - last not installed"
fi

##UPTIME 
let upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
let secs=$((${upSeconds}%60))
let mins=$((${upSeconds}/60%60))
let hours=$((${upSeconds}/3600%24))
let days=$((${upSeconds}/86400))
UPTIME=`printf "%d days, %02d:%02d:%02d" "$days" "$hours" "$mins" "$secs"`

## get the load averages
read one five fifteen rest < /proc/loadavg
LOADAVG="${one}, ${five}, ${fifteen} (1, 5, 15 min)"

## Memory
MEM=$(free -m | awk 'NR==2 { printf "Total: %sMB, Used: %sMB, Free: %sMB",$2,$3,$4; }')

## Free disk space
DISK=$(df -h ~ | awk 'NR==2 { printf "Total: %sB, Used: %sB, Free: %sB",$2,$3,$4; }')

# * Calculate processes
psu=$(ps -u $ME h | wc -l)
psa=$(ps -a h | wc -l)
PROCESSES="You're running $psu which makes a total of $psa running"

## Temperature
if [[ -z /opt/vc/bin/vcgencmd ]]; then
	TEMP="$(/opt/vc/bin/vcgencmd measure_temp | cut -c "6-9") ºC"
else
	TEMP="N/A"
fi

## Auto tmux on or off?
if [[ -f $HOME/.shell/login.d/autotmux.sh ]]
	then
		TMUX_STATUS="ENABLED"
	else
		TMUX_STATUS="DISABLED"
fi

## Serial getty on or off?

if which rpi-serial-console &> /dev/null; then
	SERIAL_STATUS=$(sudo rpi-serial-console status)
else
	SERIAL_STATUS="N/A"
fi

# MOTD

echo "$(tput setaf 2)
    .~~.   .~~.
   '. \ ' ' / .'$(tput setaf 1)
    .~ .~~~..~.                      _                          _
   : .~.'~'.~. :     ___ ___ ___ ___| |_ ___ ___ ___ _ _    ___|_|
  ~ (   ) (   ) ~   |  _| .'|_ -| . | . | -_|  _|  _| | |  | . | |
 ( : '~'.~.'~' : )  |_| |__,|___|  _|___|___|_| |_| |_  |  |  _|_|
  ~ .~ (   ) ~. ~               |_|                 |___|  |_|
   (  : '~' :  )
    '~ .~~~. ~'
        '~'        $(tput setaf 3)
 
               $DATETIME

 System.............: $SYSTEM
 Last Login.........: $LOGIN
 Uptime.............: $UPTIME
 Memory.............: $MEM
 Free Disk Space....: $DISK
 Load Averages......: $LOADAVG
 Running Processes..: $PROCESSES
 Temperature........: $TEMP
 Auto tmux..........: $TMUX_STATUS
 Serial ............: $SERIAL_STATUS
$(tput sgr0)"
 