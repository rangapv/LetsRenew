#!/bin/bash
OUTPUT=`ps -ef |grep 'node app.js'|grep -v grep`
cmd=`cp /home/ubuntu/node2/app.js.https /home/ubuntu/node2/app.js`
cmd1="cd /home/ubuntu/node2; nohup sudo node app.js 2>&1 &"
if [ -z "$OUTPUT" ]
then
  echo $(eval "$cmd1")
else
  echo "the process is running"
fi
