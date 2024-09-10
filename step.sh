#!/usr/bin/env bash
#author: rangapv@yahoo.com
#TO-RUN: ./step.sh

appkill() {

argarray=("$@")

file1="${argarray[0]}"
app="${argarray[1]}"
s3=`ps -ef |grep -v grep | grep app > $file1`
s3s="$?"
#echo "s3s is $s3s"
#echo "the output is $s3"
count=0

#echo we are killing the current app which is https to run an http similar app for letencrypt challenge to work

if  [ ! -z "$file1" ]
then
while IFS= read -r line
do
    echo "$line"
    count=$((count+1))
    pid1=`echo "$line" | awk '{split($0,a," "); print a[2]}'`
    echo "the pid is $pid1"
    if [ "$pid1" -eq 1 ]
    then
       echo "Aborting app kill since pid is 1 which is a ROOT process"
       exit
    else
      if [ "$s3s" == "0" ] && [ ! -z "$file1" ]
      then
          echo "ready to kill the process $pid1 , press any key to continue"
          read inp
          s31=`sudo kill -9 $pid1`
      else
          echo "No process RUNNING app or the file is empty"
      fi
    fi

done < $file1
echo "count is $count"
else
 echo "No process RUNNING for $app or the file is empty"
fi

}


#main begins here

s1=`crontab -l`
s1s="$?"

if [ "$s1s" == "0" ] && [ ! -z "$s1" ]
then
  s2=`crontab -r`
  s2s="$?"
fi


#Preparing for current app to be stopped for licnese fetch with backup app with only http and NO-REDIRECTS

appkill file1.txt app

#getting todays date and making a backup of the https app to be restored after certificate success

filext=`date +%d-%m-%g`
s5=`cp ./app.js ./app.js.($filext)`
s5s="$?"

if  [ "$s5s" == "0" ]
then
  echo "The default certificate app is copied to namesake app.js"
  s6=`cp ./app.js.bkp2.certrenewalfile ./app.js`
  s6s="$?" 

  if [ "$s6s" == "0" ]
  then
    s7=`sudo node app.js 2>&1 > /dev/null`
    s7s="$?"
  fi

  if  [ "$s7s" == "0" ]
  then
      s8=`ps -ef |grep -v grep | grep app | wc -l`    
      s8s="$?"
  fi

  if [ "$s8" -gt "1" ] && [ "$s8s" == "0" ]
  then
      echo "The app with just http and NO-REDIRECTS is up-running so lets start the license-BOT"
      domain="vetrisoft.in"
      path2c="/home/ubuntu/node2/public"
      s9=`sudo certbot certonly --webroot -w $path2c -d $domain > certrenew-output.txt`
      s9s="$?"
      
      if [ "$s9s" == "0" ]
      then
        echo "Certifcates Generated Successfully"
      fi

  fi

fi

#Now if the certiface renewal is success then lets swap back the http app.js with our already saved https namesake app

if [ "s9s" == "0" ] && [ ! -z ./certrenew-output.txt ]
then

appkill file2.txt app
s10=`cp ./app.js.($filext) ./app.js`
s10s="$?"

  if [ "$s10s" == "0" ] 
  then
    s11=`sudo node app.js 2>&1 > /dev/null`
    s11s="$?"
  fi

fi


if [ "$s11s" == "0" ]
then
   echo "License Renewal is a Success check the domain $domain on a Browser to verify!"
fi

#
