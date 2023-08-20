read -p "Database name: " DBNAME
read -p "Username: " USERNAME
read -p "Type 8 Char Strong Password or Type 'Y'|'y' to Generate Random Password : " USERPASSWORD
if [ "$USERPASSWORD" = "Y" ] || [ "$USERPASSWORD" = "y" ]
then
    USERPASSWORD=$(openssl rand -base64 8)
fi
echo "Database Name: $DBNAME"
echo "Username: $USERNAME"
echo "Password: $USERPASSWORD"

mysql -e "CREATE DATABASE ${DBNAME};"
mysql -e "CREATE USER '${USERNAME}'@'%' IDENTIFIED BY '${USERPASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON ${DBNAME}.* TO '${USERNAME}'@'%';"
mysql -e "FLUSH PRIVILEGES;"
mysql -e "ALTER USER '${USERNAME}'@'%' IDENTIFIED WITH mysql_native_password BY '${USERPASSWORD}'"
sudo systemctl restart mysql