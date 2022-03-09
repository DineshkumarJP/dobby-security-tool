#!/bin/bash

test_5_9() {
	local testid="5.9"
	local desc="Ensure that the host's network namespace is not shared"
	local check="$testid - $desc"
	local output

	output=$(ifconfig | grep "100.64.11.1" | cut -d: -f2 | awk '{ print $1}')
   
    if [ "$output" == "100.64.11.1" ]; then
      pass "$check"
      return
    fi
    fail "$check"
}

test_5_10() {
	local testid="5.10"
	local desc="Ensure that the memory usage for containers is limited"
	local check="$testid - $desc"
	local output
  
	output=$(cat /sys/fs/cgroup/memory/$containername/memory.limit_in_bytes)
   
    if [ "$output" == "0" -o "$output" == "-1" ]; then
      fail "$check"
      return
    fi
    pass "$check"
}

test_5_15() {
	local testid="5.15"
	local desc="Ensure that the host's process namespace is not shared"
	local check="$testid - $desc"
	local output
  
	output=$(DobbyTool info $containername | jsonValue nsPid)
	nspid=$(echo $output | awk '{ print $1}')
		
	output=$(DobbyTool info $containername | jsonValue pid)
	pid=$(echo $output | awk '{ print $1}')

    if [ "$nspid" == "$pid" ]; then
      fail "$check"
      return
    fi
    pass "$check"
}

test_5_17() {
	local testid="5.17"
	local desc="Ensure that host devices are not directly exposed to containers"
	local check="$testid - $desc"
	local output
  
	output=$(cat /sys/fs/cgroup/devices/$containername/devices.list)
   
    if [ "$output" == "" ]; then
      pass "$check"
      return
    fi
    fail "$check"
}

test_5_28() {
	local testid="5.28"
	local desc="Ensure that the PIDs cgroup limit is used"
	local check="$testid - $desc"
	local output
  
	output=$(cat /sys/fs/cgroup/pids/$containername/pids.max)
   
    if [ "$output" == "max" ]; then
      fail "$check"
      return
    fi
    pass "$check"
}

test_5_29() {
	local testid="5.29"
	local desc="Ensure that Docker's default bridge "dobby0" is not used"
	local check="$testid - $desc"
	local output
  
	output=$(brctl show dobby0 | grep veth | awk '{ print $4}')
   
    if [ "$output" == "veth0" ]; then
      fail "$check"
      return
    fi
    pass "$check"
}
