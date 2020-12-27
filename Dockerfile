FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update &&\
    apt-get install -y \
        build-essential \
        cmake \
        git \
        xorg-dev \
        libgl1-mesa-dev \
        libglu1-mesa-dev