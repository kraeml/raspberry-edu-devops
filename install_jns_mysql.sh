MYSQL_ROOT_PASSWORD=root
echo "Install software"

echo "mysql-server mysql-server/root_password password $MYSQL_ROOT_PASSWORD" | sudo debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD" | sudo debconf-set-selections
sudo apt-get update
sudo apt install -y mysql-server


sudo sed -i 's/bind-address[[:space:]]*=[[:space:]]*127.0.0.1/bind-address = 0.0.0.0/g' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo service mysql restart
