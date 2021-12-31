
rem vcpkg install opengl:x64-windows-static
rem vcpkg install sdl2:x64-windows-static

rmdir /S /Q build
mkdir build
pushd build
cmake -A x64 -DCMAKE_BUILD_TYPE=relwithdebinfo -DVCPKG_TARGET_TRIPLET=x64-windows-static ..
cmake --build . --config relwithdebinfo -- /m:%NUMBER_OF_PROCESSORS%
popd

rem pause