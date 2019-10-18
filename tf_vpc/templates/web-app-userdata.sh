#!/bin/bash 

##########################################
## Backend Application Server Core Apps ##
##########################################

# Capture Verbose Output

set -o errexit
set -o nounset
set -o pipefail

# Install Core Apps

echo "==== installing core apps for application server ===="

sleep 10s

sudo yum update -y

for var in java maven git java-1.8.0-openjdk-devel ;
do
	sudo yum install $var -y
#sudo yum update -y ; sudo yum install java-1.8.0-openjdk-devel maven git -y $var
done

echo " ========= core apps installed ============ "

sleep 10s

# Test Install Success

echo " ======= testing if core apps succesfully installed ======== "

sleep 5s

maven_version=$(mvn --version | grep Apache | awk '/Maven/ {print$2, $3}')

echo "Maven version is $maven_version"

if [ "$maven_version" = "Maven 3.0.5" ]
then
	echo "Core tools installation successfull"
else
	echo "Core tools installation unsuccessful"
	exit
fi

sleep 10s

# run shopizer

echo " ========== setting up web shop ========== "

sleep 8s

echo " =============== initiating ============= "

sleep 5s

#username=centos
#host='aws ec2 describe-instances --region eu-west-1 --output text | grep "ASSOCIATION" | sort -u | awk '{print $3}''
#script=" cd /tmp ; pwd ; git clone https://github.com/dev-minds/dm_training_2019.git ; cd /tmp/dm_training_2019 ; git checkout develop ; cd /tmp/dm_training_2019/dm_ci/java/shopizer ;  mvn clean install ; cd /tmp/tmp/dm_training_2019/dm_ci/java/shopizer/sm-shop ; mvn spring-boot:run & "

#for var in hostname
#do
   #$script

cd /tmp/
pwd
git clone https://github.com/dev-minds/dm_training_2019.git
cd /tmp/dm_training_2019
git checkout develop
cd /tmp/dm_training_2019/dm_ci/java/shopizer
mvn clean install
cd /tmp/dm_training_2019/dm_ci/java/shopizer/sm-shop
mvn spring-boot:run &

# Test to ensure Java is listening on port 8080

Port=$(netstat -tuln | grep 8080 | awk '{print$4}')

echo " =============== testing if port is listening =============== "

sleep 5s


if [ "$Port" = ":::8080" ]
then
   echo "Port is listening"
else
   echo "Port is not listening, resolve"
   exit
fi

sleep 5s

echo " ============ all done =============== "