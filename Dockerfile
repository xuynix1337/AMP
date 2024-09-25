# Use Mono base image
FROM mono:6.12.0-slim

MAINTAINER xuynix, <xxuynix@gmail.com>

ENV USER=container HOME=/home/container

# Install necessary tools: wget and unzip
RUN apt-get update && apt-get install -y wget unzip curl && rm -rf /var/lib/apt/lists/*

# Fetch the latest release URL via GitHub API
RUN LATEST_RELEASE_URL=$(curl -s https://api.github.com/repos/AdammantiumMultiplayer/Server/releases/latest | grep "browser_download_url.*zip" | cut -d '"' -f 4) \
    && wget $LATEST_RELEASE_URL -O server.zip && adduser --disabled-password --home /home/container container


USER container

WORKDIR /home/container
    
COPY ./entrypoint.sh /entrypoint.sh
    
CMD ["/bin/bash", "/entrypoint.sh"]