#!/bin/bash
set -e

# -------- SYSTEM UPDATE --------
sudo yum update -y

# -------- INSTALL NODEJS --------
sudo curl -fsSL https://rpm.nodesource.com/setup_18.x | bash -
sudo yum install -y nodejs git mariadb105


# -------- INSTALL FLYWAY --------
cd /opt
sudo wget -qO flyway.tar.gz https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/10.11.0/flyway-commandline-10.11.0-linux-x64.tar.gz
sudo tar -xzf flyway.tar.gz
sudo ln -s /opt/flyway-10.11.0/flyway /usr/local/bin/flyway

# -------- CLONE YOUR GITHUB APP --------
cd /home/ec2-user
git clone https://github.com/NicholasMariga/aws_rds-project.git app
cd app

# -------- CREATE APP ENV FILE --------
cat <<EOF > app/.env
DB_HOST="${db_host}"
DB_USER="admin"
DB_PASSWORD="${db_password}"
DB_NAME="app_db"
DB_PORT=3306
PORT=3000
EOF

# -------- FLYWAY CONFIG --------
cat <<EOF > migrations/conf/flyway.conf
flyway.url=jdbc:mysql://${db_host}:3306/app_db
flyway.user=admin
flyway.password=${db_password}
flyway.locations=filesystem:/home/ec2-user/app/migrations/sql
EOF

# -------- RUN FLYWAY MIGRATIONS --------
sudo /opt/flyway-10.11.0/flyway -configFiles=/home/ec2-user/app/migrations/conf/flyway.conf migrate

# -------- INSTALL NODE APP DEPENDENCIES --------
cd app
sudo npm install

# -------- INSTALL & RUN PM2 (Node process manager) --------
sudo npm install -g pm2
sudo pm2 start server.js
sudo pm2 save

sudo pm2 startup systemd -u ec2-user --hp /home/ec2-user
