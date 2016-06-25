#!/bin/bash
mysql -uroot -ppass ittrenddb < /var/tmp/mysql/dev_dump.latest.sql
