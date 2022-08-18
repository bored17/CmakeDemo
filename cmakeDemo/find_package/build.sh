BASE_DIR=$(cd `dirname $0`; pwd)
echo $basepath

mkdir -p build
rm -rf build/*

cd $BASE_DIR/build
mkdir -p bar
cd $BASE_DIR/build/bar
cmake $BASE_DIR/bar -D CMAKE_INSTALL_PREFIX="$BASE_DIR/output/bar" -D CMAKE_BUILD_TYPE=Release
make VERBOSE=1
make install 


cd $BASE_DIR/build
mkdir -p foo
cd $BASE_DIR/build/foo
cmake $BASE_DIR/foo -D CMAKE_INSTALL_PREFIX="$BASE_DIR/output/foo" -D CMAKE_BUILD_TYPE=Release
make VERBOSE=1
make install 


# CMAKE_PREFIX_PATH="$BASE_DIR/output/foo/lib/cmake"

# foo_DIR="$BASE_DIR/output/foo/lib/cmake"


# CMAKE_MODULE_PATH="$BASE_DIR/output/bar/lib/cmake"




cd $BASE_DIR/build
mkdir -p main
cd $BASE_DIR/build/main
cmake $BASE_DIR/main -D CMAKE_INSTALL_PREFIX="$BASE_DIR/output/main" \
-D CMAKE_BUILD_TYPE=Release \
-D CMAKE_PREFIX_PATH="$BASE_DIR/output/foo/lib/cmake" \
-D CMAKE_MODULE_PATH="$BASE_DIR/output/bar/lib/cmake"
make VERBOSE=1
make install 