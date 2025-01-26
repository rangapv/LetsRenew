#!/usr/bin/env bash
#author: rangapv@yahoo.com
#26-01-25


install_node() {

nodev=$1
nvmv=$2

# Download and install nvm:
nis1=`curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.${nodev}/install.sh | bash`
# Download and install Node.js:
nis2=`nvm install $nvmv`
# Verify the Node.js version:

}


verify_node() {
nis3=`node -v` # Should print "v22.12.0".
nis4=`nvm current` # Should print "v22.12.0".
# Verify npm version:
nis5=`npm -v` #Should print "10.9.0".

echo "The node version is $nis3"
echo "The npm version is $nis5"
#echo "The node version is $nis3"

}

install_node 40.1 22

verify_node
