# dobby-security-tool


Dobby Security Tool is a script based tool for checking security configurations of dobby container.

It is based on CIS_Docker_Benchmark_v1.3.1 standard and influenced from docker-bench-security.

The tests are automated for each dobby containers.

Running Dobby Security Tool

git clone https://github.com/rdkcentral/dobby-security-tool.git

cd dobby-security

./dobby-security.sh -c container_name 

Ex: ./dobby-security.sh -c Netflix 

If required additional prints for more information, follow below command

  Ex: ./dobby-security.sh -c Netflix -v
  
  For help message, follow the below command
  
  Ex: ./dobby-security.sh -h
  
Options:

  -c  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mandatory &nbsp;&nbsp;&nbsp;&nbsp; Container name (Ensure the container is running)
  
  -e  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; optional &nbsp;&nbsp;&nbsp;&nbsp; Comma delimited list of specific test(s) id to exclude 
  
  -h  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; optional &nbsp;&nbsp;&nbsp;&nbsp; Print this help message
  
  -t  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; optional &nbsp;&nbsp;&nbsp;&nbsp; Comma delimited list of specific test(s) id
  
  -v  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; optional &nbsp;&nbsp;&nbsp;&nbsp; prints the additional prints
  


After excuted the script, you will get the output as test results summary.


![image](https://user-images.githubusercontent.com/79261622/162721984-5a9b5cda-851e-4282-a231-d883c502ce6a.png)

