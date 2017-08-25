#!/bin/bash

#cd /tmp
#wget http://www.ohse.de/uwe/releases/lrzsz-0.12.20.tar.gz
#tar -zxvf lrzsz-0.12.20.tar.gz
#cd lrzsz-0.12.20
#./configure && make && make install
#cd /usr/bin
#ln -s /usr/local/bin/lrz rz
#ln -s /usr/local/bin/lsz sz

# TODO 自动识别系统，自动切换apt yum dnf.
# 分离安装包
# 
# dnf install https://dev.mysql.com/get/mysql57-community-release-fc23-7.noarch.rpm
# 

echo "============================= mysql =================================="
mkdir mysqldeb
tar -xvf mysql-server_5.7.18-1debian8_amd64.deb-bundle.tar -C mysqldeb
yes | apt-get install libaio1
# yes | apt-get install libnuma1
# yes | apt-get install libmecab2

# 安装依赖有先后顺序，顺序很重要，千万不要改变，否则你就花一个小时去解决吧

dpkg -i mysqldeb/mysql-common_5.7.18-1debian8_amd64.deb
dpkg -i mysqldeb/libmysqlclient20_5.7.18-1debian8_amd64.deb
dpkg -i mysqldeb/libmysqlclient-dev_5.7.18-1debian8_amd64.deb
dpkg -i mysqldeb/libmysqld-dev_5.7.18-1debian8_amd64.deb
dpkg -i mysqldeb/mysql-community-client_5.7.18-1debian8_amd64.deb
dpkg -i mysqldeb/mysql-client_5.7.18-1debian8_amd64.deb

dpkg -i mysqldeb/mysql-community-server_5.7.18-1debian8_amd64.deb

# 安装此包的时候会出现 错误：未安装软件包libmecab2
# 此时执行：apt-get -f install  
# 安装这个jar会设置密码。


# dpkg -i mysqldeb/mysql-server_5.7.18-1debian8_amd64.deb
# 启动：service mysql start
echo "======================================================================"