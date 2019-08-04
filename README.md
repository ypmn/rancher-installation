# rancher-installation
version: '3.3'
services:
  db:
    image: rancher/rancher:latest
    restart: unless-stopped
    ports:
      - '8080:80'
      - '8443:443
    volumes:
      - /opt/rancher:/var/lib/rancher
