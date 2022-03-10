#! /bin/bash

#  Version details
version=0.1
DobbyVersion=$(DobbyDaemon --version)
crunVersion=$(crun --version)


# Load outside scripts
. ./functions/output.sh
. ./functions/functions.sh
. ./tests/1_dobby_daemon_configuration_test.sh
. ./tests/2_dobby_daemon_configuration_files_test.sh
. ./tests/3_dobby_container_images_test.sh
. ./tests/4_dobby_container_runtime_test.sh

# Check for required program(s)
req_programs 'awk grep stat sed cut DobbyDaemon DobbyTool'

# Default Values
totalpass=0
totalfail=0
totalcount=0
totalwarn=0

# Header format
header_info

# Argument Validation
if [ "$1" == "" ]; then
	printtxt "${bldmgnclr} Warning: 'Please enter valid container name' Ex:./dobby_security.sh Netflix ${txtrst}\n"
	exit 1
else
	containername=$1
	input_valid
fi

# Warn if not root
if [ "$(id -u)" != "0" ]; then
   printtxt "${bldmgnclr} Warning: 'Some tests might require root to run' ${txtrst}\n"
  sleep 3
fi

printtxt "Initializing the test $(date)\n"

# Load all the tests from tests/ and run them
main() {

printtxt "\n${bldbluclr}Dobby Daemon Configuration Test ${txtrst}"

test_2_1
test_2_9

printtxt "\n${bldbluclr}Dobby Daemon Configuration File Test ${txtrst}"

test_3_1
test_3_2
test_3_3
test_3_4
test_3_17
test_3_18

printtxt "\n${bldbluclr}Dobby Container images Test ${txtrst}"
test_4_1

printtxt "\n${bldbluclr}Dobby Continer Runtime Test ${txtrst}"

test_5_3
test_5_10
test_5_12
test_5_15
test_5_17
test_5_28
test_5_29
test_5_31

totalcount=$(($totalpass+$totalfail+$totalwarn))
printtxt "\n\n${bldbluclr}Test Results Summary${txtrst}"
printtxt "${txtrst}Total Pass 		: $totalpass"
printtxt "${txtrst}Total Fail 		: $totalfail"
printtxt "${txtrst}Total Warnings 		: $totalwarn"
printtxt "${txtrst}Total tests		: $totalcount\n"

}

main "$@"
