#!/usr/bin/env fish

# Temporary script for simulating window watching

while true
    echo (date -Iseconds)", "(xdotool getactivewindow getwindowname) >> $argv[1]
    sleep 10
end
