//
//  ShapeKitGeometry.h
//  ShapeKit
//
//  Created by Michael Weisman on 10-08-21.

// * This is free software; you can redistribute and/or modify it under
// the terms of the GNU Lesser General Public Licence as published
// by the Free Software Foundation. 
// See the COPYING file for more information.
//

#import <Foundation/Foundation.h>
#import <geos_c.h>
#import <MapKit/MapKit.h>


@interface ShapeKitGeometry : NSObject {
    NSString *wktGeom;
    NSString *geomType;
    GEOSGeometry *geosGeom;
}

@property (nonatomic,retain) NSString *wktGeom;
@property (nonatomic,retain) NSString *geomType;
@property (nonatomic) GEOSGeometry *geosGeom;

-(id)initWithWKT:(NSString *) wkt;
-(id)initWithGeosGeometry:(GEOSGeometry *)geom;
void notice(const char *fmt,...);
void log_and_exit(const char *fmt,...);

@end

@interface ShapeKitPoint : ShapeKitGeometry
{
    MKPointAnnotation *geometry;
    unsigned int numberOfCoords;
}
@property (nonatomic,retain) MKPointAnnotation *geometry;
@property (nonatomic) unsigned int numberOfCoords;
-(id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;

@end

@interface ShapeKitPolyline : ShapeKitGeometry
{
    MKPolyline *geometry;
    unsigned int numberOfCoords;
}
@property (nonatomic,retain) MKPolyline *geometry;
@property (nonatomic) unsigned int numberOfCoords;
-(id)initWithCoordinates:(CLLocationCoordinate2D[])coordinates count:(unsigned int)count;

@end

@interface ShapeKitPolygon : ShapeKitGeometry
{
    MKPolygon *geometry;
    unsigned int numberOfCoords;
}
@property (nonatomic,retain) MKPolygon *geometry;
@property (nonatomic) unsigned int numberOfCoords;

@end