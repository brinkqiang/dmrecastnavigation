#!/bin/bash

echo vcpkg install opengl:x64-linux
echo vcpkg install sdl2:x64-linux

echo sudo yum install mesa-libGL-devel
echo sudo yum install freeglut-devel

rm -rf build
mkdir build
pushd build
cmake -DCMAKE_BUILD_TYPE=relwithdebinfo -DVCPKG_TARGET_TRIPLET=x64-linux ..
cmake --build . --config relwithdebinfo -- -j$(nproc)

popd

# echo continue && read -n 1
