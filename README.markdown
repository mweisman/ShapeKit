# ShapeKit

ShapeKit is a geometry library for iOS that aims to bridge [GEOS](http://trac.osgeo.org/geos/) with Apple's MapKit.

## Requirements

ShapeKit uses the MKShape Geometries (MKPolygon, MKPointAnnotation, MKPolyline) which were added to MapKit in iOS 4.0. It has been tested on the iPhone and the iPad.

ShapeKit depends on [GEOS](http://trac.osgeo.org/geos/) and [PROJ](http://proj.osgeo.org/). There is a build script in lib\_src which will automate downloading and building universal libraries for both ARMv7 and x86 (simulator) and will copy the libraries and headers to the ShapeKit library directory. To use it, simply run the build\_libs.sh script in the lib\_src directory to install the libraries.

## Features

* ShapeKitGeometries are standard cocoa objects

	`ShapeKitPoint *myPoint = [[ShapeKitPoint alloc] initWithCoordinate:CLLocationCoordinate2DMake(0, 0)];`

* ShapeKitGeometries have standard MKShape geometries for use with MapKit

	`myPoint.geometry.title = @"Centre of the Universe";`

	`myPoint.geometry.subtitle = @"The most awesome place in the world";`

	`[myMapKitView addAnnotation:myPoint.geometry]`

* ShapeKit has spatial predicates and topology operations

	`ShapeKitPolygon *bufferedPoint = [myPoint bufferWithWidth:0.005]`
	
	`[bufferedPoint containsGeometry:myPoint] \\ Returns YES`

## Usage

After following the instructions above to set up GEOS and PROJ copy the ShapeKit Directory into your project directory, and then drag everything except the libs directory into your Xcode project. Go to the Build Phases tab for your application's target (assuming Xcode 4 here) and expand "Link Binary with Libraries". Click the "+" button and select libgeos.a, libgeos_c.a and libproj.a from the ShapeKit/libs directory. This should add the libraries to your project and automatically set the Library Search Path to enable the linker to find the libraries. Under Xcode's  Build Settings tab, search for "search path". The Library Search Path should have been changed to something like "$(inherited) "$(SRCROOT)/../ShapeKit/libs"" pointing to ShapeKit's library directory. Copy and paste this into the Header Search Path.

You will also need to add the CoreLocation and MapKit frameworks to your project. See the sample Xcode project for a simple example of a ShapeKit app.

## License

This is free software; you can redistribute and/or modify it under the terms of the GNU Lesser General Public Licence as published by the Free Software Foundation. See the COPYING file for more information.
