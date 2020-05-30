#!/usr/bin/env fish

function prep_line -a log_line
    echo (string replace -a "—" "-" $log_line)
end

function window_title -a log_line -d "Return full window title from log line."
    echo (string split -m 1 -n ", " $log_line | tail -1)
end

function window_app -a log_line -d "Return Application name from log line."
    echo (window_title $log_line | string split -r -m 1 -n " - " | tail -1)
end

function summarize -a log_file
    for line in (cat $log_file)
        echo (window_app (prep_line $line))
    end
end

function summary_line_time -a summary_line
    set -l n_units (string trim $summary_line | cut -d " " -f1)
    # # Each unit is 10 second duration
    echo (math $n_units" * 10 * 1000" | humanize_duration)
end

for line in (summarize $argv[1] | grep -v "^\$" | sort | uniq -c | sort -nr)
    echo (string trim $line | cut -d " " -f2-) " [" (summary_line_time $line) "]"
end
