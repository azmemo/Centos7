# Funcion to adjust console screen brightness as a user-defined percentage
#
# /sys/class/backlight/intel_backlight/brightness must be set to rw for all users.
#
# To ensure this configuration, append the following command into /etc/rc.local
#   chmod 666 /sys/class/backlight/intel_backlight/brightness
#
# Then run the following command
#   chmod +x /etc/rc.d/rc.local

setbright(){

pct=$1

if [ $pct -gt 100 ]; then
  echo "Value must be between 5 and 100";
  return;
fi

if [ $pct -lt 5 ]; then
  echo "Value must be between 5 and 100";
  return;
fi

max=$(cat /sys/class/backlight/intel_backlight/max_brightness)
lvl=$(($pct*$max/100))

echo $lvl > /sys/class/backlight/intel_backlight/brightness
echo "Brightness set to $pct% ($lvl)"
}

export -f setbright
