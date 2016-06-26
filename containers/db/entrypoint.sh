#!/bin/bash
mysql -uroot -ppass mydb < /var/tmp/mysql/dev_dump.latest.sql
