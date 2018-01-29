#!/bin/bash

/etc/start-hdfs.sh

if [ "${MASTER}" == "${HOSTNAME}" ]; then
  # Run spark master on MASTER
  echo 'Starting Spark Master....'
  $SPARK_HOME/sbin/start-master.sh
  sleep 5

elif [ "${WORKER}" ]; then
  #start spark slave
  echo 'Starting Spark Slave....'
   $SPARK_HOME/sbin/start-slave.sh spark://${MASTER}:7077
fi

if [[ $1 == "-d" ]]; then
  while [ 1 ]
  do
   sleep 1000
  done
elif [[ $1 == "-bash" ]]; then
  /bin/bash
fi