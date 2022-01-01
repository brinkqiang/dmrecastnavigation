#!/bin/bash

echo vcpkg install opengl:x64-linux
echo vcpkg install sdl2:x64-linux

if [ -f /etc/redhat-release ]; then
  sudo yum install -y mesa-libGL-devel
  sudo yum install -y freeglut-devel
  sudo yum install -y SDL2-devel
fi

if [ -f /etc/lsb-release ]; then
  sudo apt install -y build-essential 
  sudo apt install -y libgl1-mesa-dev
  sudo apt install -y libglu1-mesa-dev 
  sudo apt install -y freeglut3-dev
  sudo apt install -y sdl2-dev
fi

rm -rf build
mkdir build
pushd build
cmake -DCMAKE_BUILD_TYPE=relwithdebinfo -DVCPKG_TARGET_TRIPLET=x64-linux ..
cmake --build . --config relwithdebinfo -- -j$(nproc)

popd

# echo continue && read -n 1
