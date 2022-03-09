#!/bin/bash

test_4_1() {
	local testid="4.1"
	local desc="Ensure that a user for the container has been created"
	local check="$testid - $desc"
	local child_pid
	local DobbyInit_PID
	local output
	
	DobbyInit_PID=$(ps -fe | grep DobbyInit | grep $containername | awk '{print $2}')
	
	child_pid=$(ps h --ppid $DobbyInit_PID -o pid | sed 's/ //g')

	output=$(cat /proc/$child_pid/status | grep '^Uid:' | awk '{print $3}')
   
    if [ "$output" == "0"  ]; then
      fail "$check"
      return
    fi
    pass "$check"
}
