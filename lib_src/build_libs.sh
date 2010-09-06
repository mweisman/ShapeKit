#!/usr/bin/sh

echo "Downlaoding GEOS source..."
curl -O "http://download.osgeo.org/geos/geos-3.2.2.tar.bz2"

echo "Unpacking GEOS source..."
tar jxf geos-3.2.2.tar.bz2

echo "Copying build script to GEOS source directory..."
cp build_ios geos-3.2.2

echo "Building GEOS..."
cd geos-3.2.2
sh build_ios device
make clean
sh build_ios simulator
cd ..

echo "Downloading PROJ4 source..."
curl -O http://download.osgeo.org/proj/proj-4.7.0.tar.gz

echo "Unpacking PROJ4 source..."
tar zxf proj-4.7.0.tar.gz

echo "Copying build script to PROJ4 source directory..."
cp build_ios proj-4.7.0

echo "building PROJ4"
cd proj-4.7.0
sh build_ios device
make clean
sh build_ios simulator
cd ..

echo "All Done!"