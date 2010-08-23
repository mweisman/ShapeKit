# GeoKit

GeoKit is a geometry library for iOS that aims to bridge [GEOS](http://trac.osgeo.org/geos/) with Apple's MapKit.

## Requirements

GeoKit uses the MKShape Geometries (MKPolygon, MKPointAnnotation, MKPolyline) which were added to MapKit in iOS 4.0. It has been tested on the iPhone, and will most likely just work on the iPad when iOS 4 is released for it.

GeoKit depends on GEOS. There is a build script in GEOS which will automate building the library for both ARM and x86 (simulator) and will copy the libraries and headers to ~/Developer. To use it, [download GEOS](http://download.osgeo.org/geos/geos-3.2.2.tar.bz2) and copy the build script to the geos source directory. Then simply run `sh build_ios device && make clean && build_ios simulator` to install the libraries and headers to ~/Developer. Next, drag one copy each of libgeos.a and libgeos_c.a to the Frameworks folder in your project's Xcode window. Finally, double-click on the project's Target and in the Build tab of the Info window that pops up, add `$(HOME)/$(SDK_DIR)/include` to the Header Search Path, and `$(HOME)/$(SDK_DIR)/lib` to the Library Search Path. Now Xcode should be able to find the GEOS library.

## Features

* GeoKitGeometries are standard cocoa objects

	`GeoKitPoint *myPoint = [[GeoKitPoint alloc] initWithWKT:@"POINT(0 0)"];`

* GeoKitGeometries have standard MKShape geometries for use with MapKit

	`myPoint.geometry.title = @"Centre of the Universe";`

	`myPoint.geometry.subtitle = @"The most awesome place in the world";`

	`[myMapKitView addAnnotation:myPoint.geometry]`

* GeoKitGeometries also have GEOS geometries for use with the GEOS C API

	`GEOSGeometry *bufferedPoint = GEOSBuffer(myPoint.geosGeom, 1, 0);`
	
	(NOTE: the plan is to eventually abstract the underlying GEOS functions away behind Objective-C wrappers)
	
* GEOS functions are abstracted into Objective-C methods that operate directly on GeoKitGeometries

	`GeoKitGeometry *polygon = [[GeoKitGeometry alloc] initWithWKT:@"POLYGON((-1 -1, -1 1, 1 1, 1 -1, -1 -1))"];`
	
	`[polygon contains:myPoint] \\ Returns YES`

## Usage

After following the instructions above to set up GEOS, simply drag the GeoKit folder into Xcode. You will also need to add the CoreLocation and MapKit frameworks to your project. See the sample Xcode project for a simple example of a GeoKit app.

## Future

Obviously this library is far from done. The next steps are to add GeoKitPolygon and GeoKitPolyline classes. Down the line it would be nice to have more initialization options than WKT, such as WKB or even MKShape geometries. Eventually all GEOS predicate, topology and miscellaneous should be wrapped in Objective-C as well.

## License

This is free software; you can redistribute and/or modify it under the terms of the GNU Lesser General Public Licence as published by the Free Software Foundation. See the COPYING file for more information.
