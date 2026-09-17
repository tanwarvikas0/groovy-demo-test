FROM ubuntu:22.04

LABEL maintainer="tanwarvikas@gmail.com"

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install Apache, zip utilities, and curl using apt
RUN apt update && \
    apt install -y apache2 zip unzip curl && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

# Download using curl to avoid TLS errors, extract files, and clean up
RUN curl -sSL -A "Mozilla/5.0" "https://www.free-css.com/assets/files/free-css-templates/download/page247/kindle.zip" -o kindle.zip && \
    unzip -q kindle.zip && \
    cp -rvf markups-kindle/* . && \
    rm -rf __MACOSX markups-kindle kindle.zip

EXPOSE 80

# Run Apache in the foreground for Ubuntu
CMD ["apache2ctl", "-D", "FOREGROUND"]
