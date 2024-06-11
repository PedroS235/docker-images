FROM osrf/ros:humble-desktop-full

# Environment Variables
ENV RMW_IMPLEMENTATION=rmw_cyclonedds_cpp 
ENV NODE_VERSION=20

RUN apt update && apt install --no-install-recommends -y \
    ninja-build gettext cmake unzip curl build-essential curl python3-venv \
    ros-$ROS_DISTRO-rmw-cyclonedds-cpp ros-$ROS_DISTRO-rviz2 iputils-ping


# Install Neovim
WORKDIR /root/
RUN git clone https://github.com/neovim/neovim .neovim
WORKDIR /root/.neovim
RUN make CMAKE_BUILD_TYPE=RelWithDebInfo
RUN make install


# Clone Neovim Config
WORKDIR /root/.config
RUN git clone https://github.com/PedroS235/nvim-conf.git nvim


# Install Nodejs
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"

# Install Fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
RUN ~/.fzf/install --all


RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc
RUN echo "[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh # FZF" >> ~/.bashrc
RUN echo "alias nv=nvim" >> ~/.bashrc
RUN echo "set -o vi" >> ~/.bashrc

WORKDIR /root/ros_ws
