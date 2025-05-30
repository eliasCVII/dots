#!/bin/bash

output=$(emacsclient --eval '(when (org-clocking-p) (org-clock-get-clock-string))' 2>&1)
status=$?

if [ $status -ne 0 ]; then
    echo "Emacs server not running"
elif [ -z "$output" ] || [[ "$output" == 'nil' ]]; then
    echo "No task"
else
    # Remove quotes and trailing spaces if needed
    result=$(echo "$output" | awk -F'"' '{print $2}' | xargs)
    echo "$result"
fi
