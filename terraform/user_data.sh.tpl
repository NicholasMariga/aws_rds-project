#!/bin/bash
set -e

# -------- SYSTEM UPDATE --------
yum update -y

# -------- INSTALL NODEJS --------
curl -fsSL https://rpm.nodesource.com/setup_18.x | bash -
yum install -y nodejs git mysql

# -------- INSTALL FLYWAY --------
cd /opt
wget -qO flyway.tar.gz https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/10.11.0/flyway-commandline-10.11.0-linux-x64.tar.gz
tar -xzf flyway.tar.gz
ln -s /opt/flyway-10.11.0/flyway /usr/local/bin/flyway

# -------- CLONE YOUR GITHUB APP --------
cd /home/ec2-user
git clone https://github.com/<YOUR_GITHUB_USERNAME>/<YOUR_APP_REPO>.git app
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
mkdir -p migrations/conf
cat <<EOF > migrations/conf/flyway.conf
flyway.url=jdbc:mysql://${db_host}:3306/app_db
flyway.user=admin
flyway.password=${db_password}
EOF

# -------- RUN FLYWAY MIGRATIONS --------
flyway -configFiles=migrations/conf/flyway.conf migrate

# -------- INSTALL NODE APP DEPENDENCIES --------
cd app
npm install

# -------- INSTALL & RUN PM2 (Node process manager) --------
npm install -g pm2
pm2 start server.js
pm2 save

pm2 startup systemd -u ec2-user --hp /home/ec2-user
