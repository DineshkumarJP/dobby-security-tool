# dobby-security-tool


Dobby Security Tool is a script based tool for checking security configurations of dobby container.

It is based on CIS_Docker_Benchmark_v1.3.1 standard and heavily influenced from docker-bench-security.

The tests are automated for each dobby containers.

**Running Dobby Security Tool**

git clone https://github.com/DineshkumarJP/dobby-security-tool.git

cd dobby-security

./dobby-security.sh container_name

Ex: ./dobby-security.sh Netflix

After excuted the script, you will get the outout as test results summary.
