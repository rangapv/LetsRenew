#Author:rangapv@yahoo.com
#19-12-24
#debian based so apt-get works
FROM node:slim 

RUN mkdir /home/app

COPY ./new.tar /home/app

RUN tar -C /home/app/ -xf /home/app/new.tar

ENTRYPOINT ["/usr/local/bin/node", "/home/app/app.js.bkp2.certrenewalfile"]
