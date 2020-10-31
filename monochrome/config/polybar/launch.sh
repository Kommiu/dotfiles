#!/usr/bin/env sh

## Add this to your wm startup file.

  killall -q polybar

  while pgrep -u $UID -x polybar > /dev/null; do sleep 0.1; done
# Terminate already running bar instances
(
  flock 200


  outputs=$(xrandr --query | grep " connected" | cut -d" " -f1)
  tray_output=eDP1

  for m in $outputs; do
    if [[ $m == "HDMI2" ]]; then
        tray_output=$m
    fi
  done

  for m in $outputs; do
    export MONITOR=$m
    export TRAY_POSITION=none
    if [[ $m == $tray_output ]]; then
      TRAY_POSITION=center
    fi

    polybar -c ~/.config/polybar/config.ini top </dev/null >/var/tmp/polybar-$m.log 2>&1 200>&- &
	polybar -c ~/.config/polybar/config.ini bottom &
    disown
  done
) 200>/var/tmp/polybar-launch.lock

#killall -q polybar

# Wait until the processes have been shut down
#while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
#polybar -c ~/.config/polybar/config.ini top &
#polybar -c ~/.config/polybar/config.ini bottom &
