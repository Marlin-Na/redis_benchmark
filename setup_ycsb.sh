#!/usr/bin/env bash

cd YCSB-master
mvn -pl site.ycsb:redis-binding -am clean package
