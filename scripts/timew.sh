#!/bin/env bash

timer="$(timew | tail -n 1 | awk '{$1=""; print $0}')"
name="$(timew | head -n 1 | awk '{$1=""; print $0}')"

echo $time
echo $name
