#!/bin/bash

test_5_3() {
	local testid="5.3"
	local desc="Ensure that Linux kernel capabilities are restricted within containers"
	local check="$testid - $desc"
	local output
	local DobbyInit_PID
	
	DobbyInit_PID=$(ps -fe | grep DobbyInit | grep $containername | awk '{print $2}')
	
	status=$(cat /proc/$DobbyInit_PID/status | grep CapPrm | awk '{print $2}')
	output=$(capsh --decode=$status | sed 's/.*=//g')
	input=( cap_net_raw cap_dac_read_search cap_sys_module cap_sys_admin cap_sys_ptrace )
	IFS=','
	read -a ouputarr <<<"$output"
	#accessing each element of array
	for i in "${!ouputarr[@]}";
	do
		for j in "${!input[@]}";
		do
			if [ "${input[$j]}" == "${ouputarr[$i]}" ]; then
				fail "$check"
				return
			elif [ "${input[$j]}" == "${ouputarr[$i]}" ]; then
				fail "$check"
				return
			elif [ "${input[$j]}" == "${ouputarr[$i]}" ]; then
				fail "$check"
				return
			elif [ "${input[$j]}" == "${ouputarr[$i]}" ]; then
				fail "$check"
				return
			fi
		done
	done
	pass "$check"
}

test_5_5() {
        local testid="5.5"
        local desc="Ensure sensitive host system directories are not mounted on containers"
        local check="$testid - $desc"
        local output
        local Dobby_pid

	Dobby_pid=$(ps -fe | grep DobbyInit | grep $containername | awk '{print $2}')
        output_1=$(cat /proc/$Dobby_pid/mounts | grep "etc")
        output_1=$(echo $output_1 | grep "rw")

        output_2=$(cat /proc/$Dobby_pid/mounts | grep  -E 'bin|sbin|usr/bin|opt/logs')

         if [ "$output_1" == "" -a "$output_2" == "" ]; then
            pass "$check"
            return
        fi
            fail "$check"
	
}

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
   	
	total=$(cat /sys/fs/cgroup/memory/memory.limit_in_bytes)
    
	if [ "$output" == "0" -o "$output" == "-1" -o "$output" == "$total" ]; then
      fail "$check"
      return
    fi
    pass "$check"
}

test_5_12() {
        local testid="5.12"
        local desc="Ensure that the container's root filesystem is mounted as read only"
        local check="$testid - $desc"
        local output
        local Dobby_pid

        Dobby_pid=$(ps -fe | grep DobbyInit | grep $containername | awk '{print $2}')
        output=$(cat /proc/$Dobby_pid/mounts | grep "/ ")
        output_1=$(echo $output | awk '{ print $4}')

        if [ "$output_1" == "ro" ]; then
              pass "$check"
                return
        fi
              fail "$check"

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
	local desc="Ensure that Dobby's default bridge "dobby0" is not used"
	local check="$testid - $desc"
	local output
	local output_1
  
	output=$(brctl show dobby0 | grep veth | awk '{ print $4}')
   	output_1=$(brctl show | grep dobby0 | awk '{ print $1}')
    
    if [ "$output" == "veth0" -o "$output_1" == "dobby0" ]; then
      fail "$check"
      return
    fi
    pass "$check"
}

test_5_31() {
	local testid="5.31"
        local desc="Ensure that the Dobby socket is not mounted inside any containers"
        local check="$testid - $desc"
        local output
	local Dobby_pid

	Dobby_pid=$(ps -fe | grep DobbyInit | grep $containername | awk '{print $2}')	
	output=$(find /proc/$Dobby_pid/root/* -iname dobbyPty.sock | grep -v find)
	
	if [ "$output" == "" ]; then
      pass "$check"
      return
    fi
    fail "$check"

}
