FROM ubuntu:22.04

LABEL maintainer="tanwarvikas@gmail.com"
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y apache2 zip unzip curl && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

# Download from GitHub release (no bot protection/TLS blocks)
RUN curl -sSL "https://github.com/StartBootstrap/startbootstrap-agency/archive/refs/tags/v7.0.12.zip" -o website.zip && \
    unzip -q website.zip && \
    cp -rvf startbootstrap-agency-7.0.12/* . && \
    rm -rf startbootstrap-agency-7.0.12 website.zip

EXPOSE 80
CMD ["apache2ctl", "-D", "FOREGROUND"]
