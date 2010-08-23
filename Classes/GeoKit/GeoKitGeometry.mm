//
//  GeoKitGeometry.m
//  GeoKit
//
//  Created by Michael Weisman on 10-08-21.

// * This is free software; you can redistribute and/or modify it under
// the terms of the GNU Lesser General Public Licence as published
// by the Free Software Foundation. 
// See the COPYING file for more information.
//

#import "GeoKitGeometry.h"
#import <geos_c.h>


@implementation GeoKitGeometry
@synthesize wktGeom,geomType,geosGeom;

#pragma mark GeoKitPoint init and dealloc methods
- (id) init
{
    self = [super init];
    if (self != nil) {
        // initialize GEOS library
        initGEOS(notice, log_and_exit);
    }
    return self;
}


-(id)initWithWKT:(NSString *) wkt {
    [self init];
    geosGeom = GEOSGeomFromWKT([wkt UTF8String]);
    self.geomType = [NSString stringWithUTF8String:GEOSGeomType(geosGeom)];
    self.wktGeom = [NSString stringWithUTF8String:GEOSGeomToWKT(geosGeom)];
    
    return self;
}


- (void) dealloc
{
    [geomType release];
    [wktGeom release];
    GEOSGeom_destroy(geosGeom);
    finishGEOS();
    [super dealloc];
}

#pragma mark GEOS binary predicates
-(BOOL)contains:(GeoKitGeometry *)compareGeometry {
    BOOL contains = GEOSContains(geosGeom, compareGeometry.geosGeom);
    return contains;
}

#pragma mark GEOS init functions
void notice(const char *fmt,...) {
	va_list ap;
    
    fprintf( stdout, "NOTICE: ");
    
	va_start (ap, fmt);
    vfprintf( stdout, fmt, ap);
    va_end(ap);
    fprintf( stdout, "\n" );
}

void log_and_exit(const char *fmt,...) {
	va_list ap;
    
    fprintf( stdout, "ERROR: ");
    
	va_start (ap, fmt);
    vfprintf( stdout, fmt, ap);
    va_end(ap);
    fprintf( stdout, "\n" );
	exit(1);
}

@end

#pragma mark -

@implementation GeoKitPoint
@synthesize geometry,numberOfCoords;

-(id)initWithWKT:(NSString *) wkt {
    [super initWithWKT:wkt];
    GEOSCoordSequence *sequence = GEOSCoordSeq_clone(GEOSGeom_getCoordSeq(geosGeom));
    geometry = [[MKPointAnnotation alloc] init];
    double xCoord;
    GEOSCoordSeq_getX(sequence, 0, &xCoord);
    
    double yCoord;
    GEOSCoordSeq_getY(sequence, 0, &yCoord);
    geometry.coordinate = CLLocationCoordinate2DMake(yCoord, xCoord);
    
    GEOSCoordSeq_getSize(sequence, &numberOfCoords);
    GEOSCoordSeq_destroy(sequence);
        
    return self;
}

- (void) dealloc
{
    [geometry release];
    [super dealloc];
}

@end

#pragma mark -

@implementation GeoKitPolyline
@synthesize geometry,numberOfCoords;

-(id)initWithWKT:(NSString *) wkt {
    [super initWithWKT:wkt];
    GEOSCoordSequence *sequence = GEOSCoordSeq_clone(GEOSGeom_getCoordSeq(geosGeom));
    GEOSCoordSeq_getSize(sequence, &numberOfCoords);
    CLLocationCoordinate2D coords[numberOfCoords];
    
    for (int coord = 0; coord < numberOfCoords; coord++) {
        double xCoord = NULL;
        GEOSCoordSeq_getX(sequence, coord, &xCoord);
        
        double yCoord = NULL;
        GEOSCoordSeq_getY(sequence, coord, &yCoord);
        coords[coord] = CLLocationCoordinate2DMake(yCoord, xCoord);
    }
    geometry = [MKPolyline polylineWithCoordinates:coords count:numberOfCoords];

    GEOSCoordSeq_destroy(sequence);
    
    return self;
}

@end
