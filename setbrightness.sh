# This file defines the funcion setbright to adjust console screen brightness to a user-defined
# percentage while using Centos 7 in run level 3 or below on a laptop.
#
# This file must be placed in /etc/profile.d
# 
# All users must read-write privileges /sys/class/backlight/intel_backlight/brightness
# To ensure this configuration on system startup:
#
# Append the following command into /etc/rc.local
#   chmod 666 /sys/class/backlight/intel_backlight/brightness
#
# Run the following command
#   chmod +x /etc/rc.d/rc.local

setbright(){

# Define variables

pct=$1;
max=$(cat /sys/class/backlight/intel_backlight/max_brightness);
lvl=$(($pct*$max/100));

# Verify parameters and adjust monitor brightness if valid, else return error

if [ $pct -lt 5 ];then
  echo "Value must be between 5 and 100";return;
elif [ $pct -gt 100 ];then
  echo "Value must be between 5 and 100";return;
else
  echo $lvl > /sys/class/backlight/intel_backlight/brightness
  echo "Screen brightness set to $pct% ($lvl)"
fi
}

export -f setbright
