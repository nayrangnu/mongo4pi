#!/bin/bash
if [ $(id -u) != 0 ]; then
    exec sudo -- "$0" "$@"
    exit
fi

echo "Creating mongodb user"
adduser --firstuid 100 --ingroup nogroup --shell /etc/false --disabled-password --gecos "" --no-create-home mongodb

echo "Installing mongo to /opt/mongo..."
tar xfz mongo.tar.gz -C /opt --owner mongodb

echo "Creating runtime directories under /var"
install -o mongodb -g nogroup -d /var/log/mongodb/
install -o mongodb -g nogroup -d /var/lib/mongodb/

echo "Installing config scripts"
#install mongod /etc/init.d
install mongo.conf /etc/init
install mongodb.conf /etc

#echo "Setting mongod to start on boot"
#update-rc.d mongod defaults

echo "Starting mongod"
#/etc/init.d/mongod start
mongo start

echo "done."

