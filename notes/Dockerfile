# Use the latest Ubuntu image
FROM ubuntu:latest

# Add metadata to the image
LABEL name="saikiran"

# Create /app directory and add a new user and group
RUN mkdir /app \
    && groupadd appuser && useradd -r -g appuser appuser

# Set the working directory
WORKDIR /app

# Set environment variables
ENV AWS_ACCESS_KEY_ID=DUMMYKEY \
    AWS_SECRET_KEY_ID=DUMMYKEY \
    AWS_DEFAULT_REGION=US-EAST-1A

# Copy files to the container
COPY index.nginx-debian.html /var/www/html/
COPY scorekeeper.js /var/www/html/
ADD style.css /var/www/html/
ADD https://releases.hashicorp.com/terraform/1.9.0/terraform_1.9.0_linux_amd64.zip /var/www/html/

# Define build arguments
ARG T_VERSION='1.6.6'
ARG P_VERSION='1.8.0'

# Expose port 80
EXPOSE 80

# Install necessary packages and set up nginx
RUN apt-get update && apt-get install -y jq net-tools curl wget unzip nginx iputils-ping

# Download and set up Terraform and Packer
RUN wget https://releases.hashicorp.com/terraform/${T_VERSION}/terraform_${T_VERSION}_linux_amd64.zip \
    && wget https://releases.hashicorp.com/packer/${P_VERSION}/packer_${P_VERSION}_linux_amd64.zip \
    && unzip terraform_${T_VERSION}_linux_amd64.zip -d /usr/local/bin \
    && unzip packer_${P_VERSION}_linux_amd64.zip -d /usr/local/bin \
    && chmod +x /usr/local/bin/terraform /usr/local/bin/packer \
    && terraform version && packer version

# Set the user to appuser
USER appuser

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
