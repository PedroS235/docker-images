# ROS2 Humble Virtual Environment

This Dockerfile is made with the intuition of having a fully isolated ROS2 environment. It can be usefull for 2 things:

1. Isolates completely ROS from system
2. Useful if not running Ubuntu as their OS.

You can still enjoy the GUI apps such as rviz, don't worry 😏.

## Usage

> [!TIP]
> You can modify the current Dockerfile to have your preferred packages. By default, it has neovim installed with my custom [config](https://github.com/PedroS235/nvim_conf). It has lsp support for python and c/cpp.

> [!IMPORTANT]
> You will need to have also ssh keys available in order for this to work.

A [script](../scripts/ros) is available which is advised to place it in a location that is defined in your `PATH`, for instance in `~.local/bin`. Therefore, you can just type `ros` in your terminal and the script will be launched.

Once you run the script, if no image or container is already created, it will first build the image and create the container. Then it will execute the container.

> [!IMPORTANT]
> Before you start, please open the script and modify the `DOCKERFILE_DIR_PATH`, `SSH_PRIVATE_KEY_PATH` and `SSH_KEYS_PATH` so that it contains the right paths.

## Manual Steps

### Build Command

```sh
docker build -t ros_humble_venv --ssh default=$HOME/.ssh/id_ed25519 .
```

### Run Command

```sh
docker run -it --name ros_humble --net=host --privileged -e DISPLAY=$DISPLAY -v ~/ros_repos/:/root/ros_ws:rw -v ~/.ssh:/root/.ssh --pid=host --ipc=host ros_humble_venv
```

> [!NOTE]
> Make sure to have a directory that will be shared between the container and your local pc. In this case, mine lives in ~/ros_repos, which links to /root/ros_ws inside the container

### Execute Container

```
docker exec -ti ros_humble
```
