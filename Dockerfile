FROM codercom/code-server:3.10.2

USER coder

COPY deploy-container/settings.json .local/share/code-server/User/settings.json

ENV SHELL=/bin/bash


RUN sudo apt-get update && sudo apt-get install unzip -y
RUN curl https://rclone.org/install.sh | sudo bash


COPY deploy-container/rclone-tasks.json /tmp/rclone-tasks.json


RUN sudo chown -R coder:coder /home/coder/.local

ENV PORT=8080

COPY deploy-container/entrypoint.sh /usr/bin/deploy-container-entrypoint.sh
ENTRYPOINT ["/usr/bin/deploy-container-entrypoint.sh"]

FROM codercom/code-server:latest

USER root
RUN sudo apt-get update && sudo apt-get -y install python3 python3-pip

