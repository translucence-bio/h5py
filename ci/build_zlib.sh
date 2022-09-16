# Build zlib-ng on unix (not tested on MacOS)
set -e

if [ -z "$HDF5_DIR" ]; then
  echo "HDF5_DIR must be defined."
  exit 1
fi

if [ -z "$ZLIB_NG_VERSION" ]; then
  ZLIB_NG_VERSION="2.0.6"
fi

pushd /tmp
wget "https://github.com/zlib-ng/zlib-ng/archive/refs/tags/${ZLIB_NG_VERSION}.zip"
unzip "${ZLIB_NG_VERSION}.zip"
mkdir zlib-ng-build
cmake "-DZLIB_COMPAT:BOOL=ON" "-DCMAKE_INSTALL_PREFIX:PATH=$HDF5_DIR" -S "zlib-ng-${ZLIB_NG_VERSION}" -B zlib-ng-build
cmake --build zlib-ng-build --config Release --target install
popd
