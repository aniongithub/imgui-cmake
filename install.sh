#!/bin/bash

[ -d "build" ] && rm -rf build
mkdir build
cd build
cmake ..
make
make install
