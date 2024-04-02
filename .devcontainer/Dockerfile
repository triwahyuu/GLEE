FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y locales \
    && locale-gen en_US.UTF-8 \
    && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 \
    && ln -fs /usr/share/zoneinfo/UTC /etc/localtime \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y tzdata \
    && dpkg-reconfigure --frontend noninteractive tzdata
ENV LANG en_US.UTF-8

RUN apt-get update && apt-get -y upgrade \
    && apt-get install -y --no-install-recommends \
        sudo curl wget gnupg2 lsb-release software-properties-common \
        ssh git git-lfs jq ffmpeg dkms build-essential libxcb-xinerama0 \
        libqt5gui5 libx11-xcb-dev libglu1-mesa-dev libxrender-dev \
        libxi-dev libxkbcommon-dev libxkbcommon-x11-dev \
    && rm -rf /var/lib/apt/lists/*

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.10 100 && \
    apt install -y python3-pip && \
    python -m pip install pip --upgrade && \
    pip install pre-commit==3.0.2 packaging jupyter ipywidgets setuptools==58.2.0 && \
    pip install torch==2.1.2 torchvision==0.16.2 -f https://download.pytorch.org/whl/cu118/torch_stable.html && \
    # pip install git+https://github.com/facebookresearch/detectron2.git
    pip install gradio==4.11.0 transformers==4.36.0 timm opencv-python shapely==1.7.1 && \
    pip install Pillow==9.1.1 lvis scipy fairscale xformers einops ftfy tensorboard cython

ENV LD_LIBRARY_PATH=/usr/local/lib/python3.10/dist-packages/torch/lib:$LD_LIBRARY_PATH

WORKDIR /tmp/glee
COPY . .
RUN pip install -e .

# USER $USERNAME
WORKDIR /
