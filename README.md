# dobby-security-tool


Dobby Security Tool is a script based tool for checking security configurations of dobby container.

It is based on CIS_Docker_Benchmark_v1.3.1 standard and influenced from docker-bench-security.

The tests are automated for each dobby containers.

Running Dobby Security Tool

git clone https://github.com/DineshkumarJP/dobby-security-tool.git

cd dobby-security

./dobby-security.sh -c container_name 

Ex: ./dobby-security.sh -c Netflix 

If required additional prints for more information, follow below command
  Ex: ./dobby-security.sh -c Netflix -V
For help message, follow the below command
  Ex: ./dobby-security.sh -h
  
Options:
  -c           Container name (Ensure the container is running)
  -h           Print this help message
  -V           prints the additional prints
  


After excuted the script, you will get the output as test results summary.
