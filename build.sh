#!/bin/bash -e

WD="$(realpath -qe .)"
: ${BUILD_SHARED_BAR:=OFF}
: ${BUILD_SHARED_FOO:=OFF}
: ${PREFIX_BAR:=prefix/bar}
: ${PREFIX_FOO:=prefix/foo}
: ${PREFIX_CLIENT:=prefix/client}
: ${NR_JOBS:=$(grep processor /proc/cpuinfo | wc -l)}

function mkbuild() {
	rm -rf build
	mkdir -p build
	cd build
}

function make() {
	$(which make) -j$NR_JOBS "$@"
}

echo ":: Deleting prefixes"
rm -rf prefix

echo
echo ":: Building bar"

cd bar
mkbuild

cmake .. -DCMAKE_INSTALL_PREFIX="$PREFIX_BAR" -DBUILD_SHARED_LIBS="$BUILD_SHARED_BAR"
make
make install/strip

cd ../..

echo
echo ":: Building foo"

cd foo
mkbuild

cmake .. -DCMAKE_INSTALL_PREFIX="$PREFIX_FOO" -DBUILD_SHARED_LIBS="$BUILD_SHARED_FOO" -DCMAKE_PREFIX_PATH="$(realpath "$PREFIX_BAR")" # relative pathes are not allowed in CMAKE_PREFIX_PATH, but in fact allowed elsewhere
make
make install/strip

cd ../..

echo
echo ":: Building client"

cd client
mkbuild

cmake .. -DCMAKE_INSTALL_PREFIX="$PREFIX_CLIENT" -DCMAKE_INSTALL_RPATH_USE_LINK_PATH=ON -DCMAKE_PREFIX_PATH="$(realpath "$PREFIX_BAR");$(realpath "$PREFIX_FOO")" # relative pathes are not allowed in CMAKE_PREFIX_PATH, but in fact allowed elsewhere
make
make install/strip

cd ../..

echo
echo ":: Building OK"

echo
echo ":: Invoking 'ldd' '$PREFIX_CLIENT/bin/client'"
ldd "$PREFIX_CLIENT/bin/client"

echo
echo ":: Invoking '$PREFIX_CLIENT/bin/client'"
"$PREFIX_CLIENT/bin/client"

echo
echo ":: All OK"
