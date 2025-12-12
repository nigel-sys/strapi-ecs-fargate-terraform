#!/bin/bash
set -e

# Install Docker
yum update -y
yum install -y docker
systemctl enable docker
systemctl start docker

cd /home/ec2-user

# Create environment file
cat <<EOF > .env
HOST=0.0.0.0
PORT=1337
NODE_ENV=development

APP_KEYS=${APP_KEYS}
API_TOKEN_SALT=${API_TOKEN_SALT}
ADMIN_JWT_SECRET=${ADMIN_JWT_SECRET}
TRANSFER_TOKEN_SALT=${TRANSFER_TOKEN_SALT}
ENCRYPTION_KEY=${ENCRYPTION_KEY}

DATABASE_CLIENT=postgres
DATABASE_HOST=${DATABASE_HOST}
DATABASE_PORT=5432
DATABASE_NAME=${DATABASE_NAME}
DATABASE_USERNAME=${DATABASE_USERNAME}
DATABASE_PASSWORD=${DATABASE_PASSWORD}
DATABASE_SSL=true
DATABASE_SSL_REJECT_UNAUTHORIZED=false
JWT_SECRET=${JWT_SECRET}
EOF


# Login to ECR
aws configure set aws_access_key_id "${AWS_ACCESS_KEY_ID}"
aws configure set aws_secret_access_key "${AWS_SECRET_ACCESS_KEY}"
aws configure set region "${AWS_REGION}"

aws ecr get-login-password --region ${AWS_REGION} \
| docker login --username AWS --password-stdin 301782007642.dkr.ecr.${AWS_REGION}.amazonaws.com

# Pull latest image
docker pull ${docker_image}

# Run Strapi container
docker run -d \
  --name strapi \
  --env-file /home/ec2-user/.env \
  -p 80:1337 \
  ${docker_image}

# Ensure it auto starts on reboot
cat <<'EOF' >/etc/systemd/system/strapi.service
[Unit]
Description=Strapi Docker Container
After=docker.service
Requires=docker.service

[Service]
Restart=always
ExecStart=/usr/bin/docker start -a strapi
ExecStop=/usr/bin/docker stop -t 2 strapi

[Install]
WantedBy=multi-user.target
EOF

# Enable service to start on reboot
systemctl daemon-reload
systemctl enable strapi
systemctl start strapi