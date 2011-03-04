#!/usr/bin/sh

mkdir -p ../ShapeKit/libs/

echo "Downlaoding GEOS source..."
curl -O "http://download.osgeo.org/geos/geos-3.2.2.tar.bz2"

echo "Unpacking GEOS source..."
tar jxf geos-3.2.2.tar.bz2

echo "Copying build script to GEOS source directory..."
cp build_ios geos-3.2.2

echo "Building GEOS..."
cd geos-3.2.2
sh build_ios -p $PWD/device_build device
make clean
sh build_ios -p $PWD/simulator_build simulator
lipo -arch i386 simulator_build/lib/libgeos.a -arch armv7 device_build/lib/libgeos.a -create -output ../../ShapeKit/libs/libgeos.a
lipo -arch i386 simulator_build/lib/libgeos_c.a -arch armv7 device_build/lib/libgeos_c.a -create -output ../../ShapeKit/libs/libgeos_c.a
cp -r simulator_build/include/* ../../ShapeKit/libs
cd ..

echo "Downloading PROJ4 source..."
curl -O http://download.osgeo.org/proj/proj-4.7.0.tar.gz

echo "Unpacking PROJ4 source..."
tar zxf proj-4.7.0.tar.gz

echo "Copying build script to PROJ4 source directory..."
cp build_ios proj-4.7.0

echo "building PROJ4"
cd proj-4.7.0
sh build_ios -p $PWD/device_build device
make clean
sh build_ios -p $PWD/simulator_build simulator
lipo -arch i386 simulator_build/lib/libproj.a -arch armv7 device_build/lib/libproj.a -create -output ../../ShapeKit/libs/libproj.a
cp -r simulator_build/include/* ../../ShapeKit/libs
cd ..

echo "All Done!"