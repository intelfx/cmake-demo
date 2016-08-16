cmake_minimum_required(VERSION 2.8)
project(Foo)

find_package(Bar)

add_library(foo
            src/foo.cpp)

target_include_directories(foo PUBLIC
                           $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
			   $<INSTALL_INTERFACE:include>)

target_link_libraries(foo PRIVATE
                      bar)

install(TARGETS foo
        DESTINATION lib
	EXPORT FooTargets)
install(DIRECTORY include/
        DESTINATION include/foo)
install(EXPORT FooTargets
	DESTINATION lib/cmake/Foo)

configure_file(FooConfig.cmake.in FooConfig.cmake @ONLY)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/FooConfig.cmake
        DESTINATION lib/cmake/Foo)
