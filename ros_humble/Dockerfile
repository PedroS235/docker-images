FROM osrf/ros:humble-desktop-full

# Environment Variables
ENV RMW_IMPLEMENTATION=rmw_cyclonedds_cpp 
ENV NODE_VERSION=20

ARG DEBIAN_FRONTEND=noninteractive

# Use them same user inside container 
ARG USER_ID
ARG GROUP_ID

# SSH keys to be used inside container
ARG ssh_prv_key
ARG ssh_pub_key

# Setup the user
RUN groupadd -g ${GROUP_ID} user && \
    useradd -u ${USER_ID} -g user -m user && \
    echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Upate system and install some dependencies
RUN apt update && apt install --no-install-recommends -y \
    ninja-build gettext cmake unzip curl build-essential curl python3-venv \
    iputils-ping ros-$ROS_DISTRO-rmw-cyclonedds-cpp ros-$ROS_DISTRO-rviz2  \
    ros-$ROS_DISTRO-gazebo-dev ros-$ROS_DISTRO-rqt-tf-tree

# Install Neovim
WORKDIR /home/user
RUN git clone https://github.com/neovim/neovim .neovim
WORKDIR /home/user/.neovim
RUN make CMAKE_BUILD_TYPE=RelWithDebInfo
RUN make install

USER user
WORKDIR /home/user

# Clone Neovim Config
WORKDIR /home/user/.config
RUN git clone https://github.com/PedroS235/nvim-conf.git nvim

# Install Nodejs
RUN curl -fsSL https://deb.nodesource.com/setup_22.x -o nodesource_setup.sh 
RUN sudo -E bash nodesource_setup.sh
RUN sudo apt-get install -y nodejs

# Install Fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
RUN ~/.fzf/install --all

# Install Cargo 
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH=$HOME/.cargo/bin:$PATH

# Install Mprocs
RUN /home/user/.cargo/bin/cargo install mprocs

# Install Starship
RUN curl -sS https://starship.rs/install.sh | sh -s -- -y

# Setup SSH keys
RUN mkdir -p -m 0700 /home/user/.ssh && \
    ssh-keyscan -H github.com >> /home/user/.ssh/known_hosts

RUN echo "$ssh_prv_key" > /home/user/.ssh/id_ed25519 && \
    echo "$ssh_pub_key" > /home/user/.ssh/id_ed25519.pub && \
    chmod 600 /home/user/.ssh/id_ed25519 && \
    chmod 600 /home/user/.ssh/id_ed25519.pub

# Setup .bashrc
COPY bashrc /home/user/.bashrc
COPY gitconfig /home/user/.gitconfig

WORKDIR /home/user

# Default Command
CMD ["/bin/bash"]
