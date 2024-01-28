cmake_minimum_required(VERSION 3.16)

set(CONFIG_CLIENT_FILES ../configs/*.json)

project(test-client)

set(CMAKE_CXX_STANDARD 17)

add_executable(test-client test-client.cpp)
