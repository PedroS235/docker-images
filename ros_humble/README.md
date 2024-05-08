## My Dockerfile for a ROS2 humble environment

This is made for me to have a fully isolated ROS environment. For everything to work
seamlessly, create the container with the `--priviledge` flag.

### Build Command
```sh
docker build -t ros_humble_venv --ssh default=$HOME/.ssh/id_ed25519 .
```

### Run Command

```sh
docker run -it --name ros_humble --net=host --privileged -e DISPLAY=$DISPLAY -v ~/ros_repos/:/root/ros_ws:rw -v ~/.ssh:/root/.ssh --pid=host --ipc=host ros_humble_venv
```

> [!NOTE]
> Make sure to have a directory that will be shared between the container and your local pc. In this case, mine lives in ~/ros_repos, which links to /root/ros_ws  inside the container

### Execute Container
```
docker exec -ti ros_humble
```
