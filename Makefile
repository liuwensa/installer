
lrzsz:
	wget --no-check-certificate http://www.ohse.de/uwe/releases/lrzsz-0.12.20.tar.gz
	tar -zxvf lrzsz-0.12.20.tar.gz
	cd lrzsz-0.12.20
	./configure && make && make install
	cd ..
	cd /usr/bin
	ln -s /usr/local/bin/lrz rz
	ln -s /usr/local/bin/lsz sz
	cd -

ntpdate:
	yes | apt-get install ntpdate
	ntpdate 210.72.145.44
	echo "0  *    * * *   root    /usr/sbin/ntpdate 192.168.165.145 >> /var/log/nptdate.log" >> /etc/crontab

editor:
	yes | apt-get install vim

build-tools:
	echo "============================ build-tools ========================"
	yes | apt-get install gcc
	yes | apt-get install g++
	yes | apt-get install make
	yes | apt-get install cmake
	echo "======================================================================"

redis:
	echo "============================ redis ================================="
	tar -zxvf redis-3.0.1.tar.gz
	cd redis-3.0.1
	make
	make install
	./utils/install_server.sh
	cd ..
	echo "======================================================================"

mysql:
	echo "============================= mysql =================================="
    unzip mysql-deb-5.6.24.zip -d mysqldeb
    cd mysqldeb
	yes | apt-get install libaio1
	dpkg -i mysqldeb/mysql-common_5.6.24-1debian7_amd64.deb
	dpkg -i mysqldeb/mysql-community-server_5.6.24-1debian7_amd64.deb
	dpkg -i mysqldeb/mysql-community-client_5.6.24-1debian7_amd64.deb
    cd ..
	echo "======================================================================"

mongodb:
	echo "============================ mongodb ================================="
	yes | apt-get install mongodb
	service mongodb stop
	tar -zxvf mongodb-linux-x86_64-3.2.1.tgz
	cp mongodb-linux-x86_64-3.2.1/bin/* /usr/bin -R
	echo "never" > /sys/kernel/mm/transparent_hugepage/defrag
	echo "never" > /sys/kernel/mm/transparent_hugepage/enabled
	service mongodb start
	echo "======================================================================"

nginx:
	echo "============================= nginx =================================="
	tar -zxvf nginx-1.9.10.tar.gz
	cd nginx-1.9.10
	yes | apt-get install libpcre3*
	yes | apt-get install zlib*
	./configure
	make
	make install
	/usr/local/nginx/sbin/nginx
	cd ..
	echo "======================================================================"

node:
	echo "============================== node =================================="
	tar -zxvf node-v4.2.6-linux-x64.tar.gz
	cp node-v4.2.6-linux-x64/* /usr -R
	echo "======================================================================"

pm2:
	echo "============================== pm2 ==================================="
	#npm install pm2 -g
	mkdir -p /usr/local/lib/node_modules
	tar -zxvf pm2-1.0.0.tar.gz -C /usr/local/lib/node_modules
	#unzip pm2.zip -d /usr/local/lib/node_modules/pm2
	ln -s /usr/local/lib/node_modules/pm2/bin/pm2 /usr/bin/pm2
	echo "======================================================================"

gm:
	echo "============================== GraphicsMagick ========================"
    unzip gm.zip -d gm
	cd gm
	chmod u+x install.sh
	source ./gm/install.sh
	cd ..
	echo "======================================================================"


all: lrzsz ntpdate editor build-tools redis mysql mongodb nginx node pm2 gm
