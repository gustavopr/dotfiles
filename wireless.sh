#!/bin/sh

iwconfig wlan0 2>&1 | grep -q no\ wireless\ extensions\. && {
  echo wired
  exit 0
}

essid=`iwconfig wlan0 | awk -F '"' '/ESSID/ {print $2}'`
stngth=`iwconfig wlan0 | awk -F '=' '/Quality/ {print $2}' | cut -d '/' -f 1`
bars=`echo $stngth | python -c "print(int(round((float(input())*10)/70)))"`


case $bars in
  0)  bar='[ ---------- ]' ;;
  1)  bar='[ |--------- ]' ;;
  2)  bar='[ ||-------- ]' ;;
  3)  bar='[ |||------- ]' ;;
  4)  bar='[ ||||------ ]' ;;
  5)  bar='[ |||||----- ]' ;;
  6)  bar='[ ||||||---- ]' ;;
  7)  bar='[ |||||||--- ]' ;;
  8)  bar='[ ||||||||-- ]' ;;
  9)  bar='[ |||||||||- ]' ;;
  10) bar='[ |||||||||| ]' ;;
  *)  bar='[ ----!!---- ]' ;;
esac

echo "Wifi:" $essid $bar

exit 0
