FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

# nvidia docker runtime env
ENV NVIDIA_VISIBLE_DEVICES \
        ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
        ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics,compat32,utility

RUN apt-get update &&\
    apt-get install -y \
        build-essential \
        cmake \
        gdb \
        git \
        libglfw3-dev \
        libglew-dev \
        libsdl2-dev \
        xorg-dev \
        apt-utils \
        dialog \
        x11-apps