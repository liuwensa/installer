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
yes | apt-get install ntpdate
ntpdate 210.72.145.44
echo "0  *    * * *   root    /usr/sbin/ntpdate 192.168.165.145 >> /var/log/nptdate.log" >> /etc/crontab

echo "============================ vim gcc g++ make ========================"
yes | apt-get install vim
yes | apt-get install gcc
yes | apt-get install g++
yes | apt-get install make
yes | apt-get install cmake
echo "======================================================================"

echo "============================ redis ================================="
tar -zxvf redis-3.0.1.tar.gz
cd redis-3.0.1
make
make install
yes | ./utils/install_server.sh
cd ..
echo "======================================================================"

echo "============================ mongodb ================================="
yes | apt-get install mongodb
service mongodb stop
tar -zxvf mongodb-linux-x86_64-3.2.1.tgz
cp mongodb-linux-x86_64-3.2.1/bin/* /usr/bin -R
echo "never" > /sys/kernel/mm/transparent_hugepage/defrag
echo "never" > /sys/kernel/mm/transparent_hugepage/enabled
service mongodb start
echo "======================================================================"

echo "============================= nginx =================================="
tar -zxvf nginx-1.12.0.tar.gz
cd nginx-1.12.0
yes | apt-get install libpcre3*
yes | apt-get install zlib*
./configure
make
make install
/usr/local/nginx/sbin/nginx
cd ..
echo "======================================================================"

echo "============================== node =================================="
tar -zxvf node-v7.6.0-linux-x64.tar.gz
cp node-v7.6.0-linux-x64/* /usr -R
echo "======================================================================"

echo "============================== GraphicsMagick ========================"
unzip gm.zip -d gm
chmod u+x ./gm/install.sh
cd gm
source ./install.sh
echo "======================================================================"
