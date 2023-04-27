#!/bin/bash


#echo $1;
echo $1;
rm -rf workshop-users-list-new.csv
for i in `seq 1 $1`;
do
	tempPass=$(openssl rand -base64 10);
	echo "\"apac-trail-user-"$i"\",\"$tempPass\",\"apacuser@testjfrog.com\"" >> workshop-users-list-new.csv;
done;
echo "" >> workshop-users-list-new.csv
