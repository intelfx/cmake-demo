cmake_minimum_required(VERSION 2.8)
project(FooClient)

find_package(Foo)

add_executable(client
               src/main.cpp)
target_link_libraries(client
                      foo)

install(TARGETS client
        DESTINATION bin)
