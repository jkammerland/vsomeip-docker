cmake_minimum_required(VERSION 3.16)

project(server)

set(CONFIG_SERVER_FILES ../configs/*.json)

set(CMAKE_CXX_STANDARD 20)

add_executable(server server.cpp ${CONFIG_SERVER_FILES})
