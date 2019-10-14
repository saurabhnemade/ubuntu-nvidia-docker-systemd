#!/bin/bash

docker stop $(docker ps -a -q --filter="name=ubuntu.minion.1")
docker rm $(docker ps -a -q --filter="name=ubuntu.minion.1")
docker run --gpus all --name ubuntu.minion.1 -d -p 3020:22 -p 47292:17292 -p 48292:18292 --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro saurabh/docker-ubuntu-nvidia-systemd:latest
docker exec -it ubuntu.minion.1 systemctl restart systemd-user-sessions.service
