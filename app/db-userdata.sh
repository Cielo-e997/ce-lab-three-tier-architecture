#!/bin/bash
yum update -y
yum install -y nc

while true; do
  echo -e "HTTP/1.1 200 OK\n\n{\"status\":\"db_healthy\",\"connections\":5}" | nc -l -p 3306
done &

while true; do
  echo -e "HTTP/1.1 200 OK\n\n{\"status\":\"db_healthy\",\"connections\":5}" | nc -l -p 5432
done &
