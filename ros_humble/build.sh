#! /bin/bash

docker build -t ros_humble_venv --ssh default=$HOME/.ssh/id_ed25519 .
docker run -it --name ros_humble --net=host --privileged -e DISPLAY=$DISPLAY \
    -v /home/pedros235/ros_repos/:/root/ros_ws:rw -v /home/pedros235/.ssh:/root/.ssh \
    --pid=host ros_humble_venv
