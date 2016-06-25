CREATE USER ittrend IDENTIFIED BY 'secret';
CREATE DATABASE ittrenddb;
GRANT ALL PRIVILEGES ON ittrenddb.* TO ittrend;
