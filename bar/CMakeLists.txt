cmake_minimum_required(VERSION 2.8)
project(Bar)

add_library(bar
            src/bar.cpp)

target_include_directories(bar PUBLIC
                           $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
			   $<INSTALL_INTERFACE:include>)

install(TARGETS bar
        DESTINATION lib
	EXPORT BarConfig)
install(DIRECTORY include/
        DESTINATION include/bar)
install(EXPORT BarConfig
        DESTINATION lib/cmake/Bar)
# no separate BarConfig.cmake because we have no dependencies
