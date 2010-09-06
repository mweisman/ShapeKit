# ShapeKit

ShapeKit is a geometry library for iOS that aims to bridge [GEOS](http://trac.osgeo.org/geos/) with Apple's MapKit.

## Requirements

ShapeKit uses the MKShape Geometries (MKPolygon, MKPointAnnotation, MKPolyline) which were added to MapKit in iOS 4.0. It has been tested on the iPhone, and will most likely just work on the iPad when iOS 4 is released for it.

ShapeKit depends on GEOS. There is a build script in lib\_src which will automate downloading and building the library for both ARM and x86 (simulator) and will copy the libraries and headers to ~/Developer. To use it, simply run the build\_libs.sh script in the lib\_src directory to install the libraries and headers to ~/Developer. Next, drag one copy each of libgeos.a and libgeos_c.a to the Frameworks folder in your project's Xcode window. Finally, double-click on the project's Target and in the Build tab of the Info window that pops up, add `$(HOME)/$(SDK_DIR)/include` to the Header Search Path, and `$(HOME)/$(SDK_DIR)/lib` to the Library Search Path. Now Xcode should be able to find the GEOS library.

## Features

* ShapeKitGeometries are standard cocoa objects

	`ShapeKitPoint *myPoint = [[ShapeKitPoint alloc] initWithCoordinate:CLLocationCoordinate2DMake(0, 0)];`

* ShapeKitGeometries have standard MKShape geometries for use with MapKit

	`myPoint.geometry.title = @"Centre of the Universe";`

	`myPoint.geometry.subtitle = @"The most awesome place in the world";`

	`[myMapKitView addAnnotation:myPoint.geometry]`

* ShapeKitGeometries also have GEOS geometries for use with the GEOS C API

	`GEOSGeometry *bufferedPoint = GEOSBuffer(myPoint.geosGeom, 1, 0);`
	
	(NOTE: the plan is to eventually abstract the underlying GEOS functions away behind Objective-C wrappers)
	
* GEOS functions are abstracted into Objective-C methods that operate directly on ShapeKitGeometries

	`ShapeKitPolygon *polygon = [[ShapeKitPolygon alloc] initWithWKT:@"POLYGON((-1 -1, -1 1, 1 1, 1 -1, -1 -1))"];`
	
	`[polygon containsGeometry:myPoint] \\ Returns YES`

## Usage

After following the instructions above to set up GEOS, simply drag the ShapeKit folder into Xcode. You will also need to add the CoreLocation and MapKit frameworks to your project. See the sample Xcode project for a simple example of a ShapeKit app.

## Future

The plan is to turn this into a more generic geo library for iOS with support for projections (through [PROJ4](http://trac.osgeo.org/proj/)) and vector data loading (though [OGR](http://www.gdal.org/ogr/)).

## License

This is free software; you can redistribute and/or modify it under the terms of the GNU Lesser General Public Licence as published by the Free Software Foundation. See the COPYING file for more information.
