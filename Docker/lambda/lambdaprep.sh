#!/usr/bin/env bash
#author:rangapv@yahoo.com

aws_configure() {


echo "enter the aws account access-id "
read accid
echo "enter the aws account secret-id"
read secid

awsconf1=`aws configure set aws_access_key_id ${accid}`
awsconf2=`aws configure set aws_secret_access_key ${secid}` 
awsconf3=`aws configure list`
awsconf3s="$?"

if [[ "$awsconf3s" -eq "0" ]]
then
	echo "aws configure was success"
	echo "$awsconf3"
else
	echo "aws configure DID NOT go through"
fi

}


docker_configure() {

echo "Enter the docker config now..."
echo "ENter the docker Login / username"
read dockname
echo "Enter the docker password"
read dockpwd
dc1=`docker login -u $dockname -p $dockpwd`
dc1s="$?"

if [[ "$dc1s" -eq "0" ]]
then
        echo "Docker configure was success"
else
        echo "Docker configure DID NOT go through"
fi
	echo "$dc1"

}

aws_configure

docker_configure
