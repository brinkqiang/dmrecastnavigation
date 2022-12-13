file(GLOB SOURCES Source/*.cpp Contrib/fastlz/fastlz.c)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

find_package(OpenGL REQUIRED)
find_package(SDL2 CONFIG REQUIRED)

include_directories(SYSTEM ${OPENGL_INCLUDE_DIR})
include_directories(SYSTEM ${SDL2_INCLUDE_DIR})
include_directories(SYSTEM Contrib/fastlz)
include_directories(SYSTEM Contrib)
include_directories(../DebugUtils/Include)
include_directories(../Detour/Include)
include_directories(../DetourCrowd/Include)
include_directories(../DetourTileCache/Include)
include_directories(../Recast/Include)
include_directories(Include)

if (WIN32)
    add_executable(RecastDemo WIN32 ${SOURCES})
elseif(APPLE)
    add_executable(RecastDemo MACOSX_BUNDLE ${SOURCES})
else()
    add_executable(RecastDemo ${SOURCES})
endif()

if( WIN32 )
  if ( "${CMAKE_MAKE_PROGRAM}" MATCHES "MSBuild" )
    add_custom_command(TARGET RecastDemo
      POST_BUILD
      #COMMAND ${CMAKE_COMMAND} -E copy "${SDL2_RUNTIME_LIBRARY}" ${CMAKE_BINARY_DIR}/RecastDemo/$(ConfigurationName)/
      COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_SOURCE_DIR}/Bin/Meshes $<TARGET_FILE_DIR:RecastDemo>/Meshes
      COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_SOURCE_DIR}/Bin/TestCases $<TARGET_FILE_DIR:RecastDemo>/TestCases
      COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/Bin/DroidSans.ttf $<TARGET_FILE_DIR:RecastDemo>
    )
  elseif ( MINGW )
    add_custom_command(TARGET RecastDemo
      POST_BUILD
      #COMMAND ${CMAKE_COMMAND} -E copy "${SDL2_RUNTIME_LIBRARY}" ${CMAKE_BINARY_DIR}/RecastDemo/
      COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_SOURCE_DIR}/Bin/Meshes $<TARGET_FILE_DIR:RecastDemo>/Meshes
      COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_SOURCE_DIR}/Bin/TestCases $<TARGET_FILE_DIR:RecastDemo>/TestCases
      COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/Bin/DroidSans.ttf $<TARGET_FILE_DIR:RecastDemo>
    )
  endif()
else()
    file(COPY Bin/Meshes DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
    file(COPY Bin/TestCases DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
    file(COPY Bin/DroidSans.ttf DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
endif()


add_dependencies(RecastDemo DebugUtils Detour DetourCrowd DetourTileCache Recast)
target_link_libraries(RecastDemo ${OPENGL_LIBRARIES} ${SDL2_LIBRARIES} DebugUtils Detour DetourCrowd DetourTileCache Recast)

install(TARGETS RecastDemo
        RUNTIME DESTINATION bin
        BUNDLE DESTINATION bin)
install(DIRECTORY Bin/Meshes DESTINATION bin)
install(DIRECTORY Bin/TestCases DESTINATION bin)
install(FILES Bin/DroidSans.ttf DESTINATION bin)

if (WIN32)
    install(FILES "${SDL2_LIBRARIES}" DESTINATION bin)
endif()