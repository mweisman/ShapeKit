//
//  ShapeKitGeometry.m
//  ShapeKit
//
//  Created by Michael Weisman on 10-08-21.

// * This is free software; you can redistribute and/or modify it under
// the terms of the GNU Lesser General Public Licence as published
// by the Free Software Foundation. 
// See the COPYING file for more information.
//

#import "ShapeKitGeometry.h"
#import <geos_c.h>


@implementation ShapeKitGeometry
@synthesize wktGeom,geomType,geosGeom;

#pragma mark ShapeKitPoint init and dealloc methods
- (id) init
{
    self = [super init];
    if (self != nil) {
        // initialize GEOS library
        handle = initGEOS_r(notice, log_and_exit);
    }
    return self;
}


-(id)initWithWKT:(NSString *) wkt {
    [self init];
    
    GEOSWKTReader *WKTReader = GEOSWKTReader_create_r(handle);
    self.geosGeom = GEOSWKTReader_read_r(handle, WKTReader, [wkt UTF8String]);
    GEOSWKTReader_destroy_r(handle, WKTReader);
    
    self.geomType = [NSString stringWithUTF8String:GEOSGeomType_r(handle, geosGeom)];
    
    GEOSWKTWriter *WKTWriter = GEOSWKTWriter_create_r(handle);
    self.wktGeom = [NSString stringWithUTF8String:GEOSWKTWriter_write_r(handle, WKTWriter,geosGeom)];
    GEOSWKTWriter_destroy_r(handle, WKTWriter);
    
    return self;
}


-(id)initWithGeosGeometry:(GEOSGeometry *)geom {
    [self init];
    geosGeom = geom;
    self.geomType = [NSString stringWithUTF8String:GEOSGeomType_r(handle, geosGeom)];
    GEOSWKTWriter *WKTWriter = GEOSWKTWriter_create_r(handle);
    self.wktGeom = [NSString stringWithUTF8String:GEOSWKTWriter_write_r(handle, WKTWriter,geosGeom)];
    GEOSWKTWriter_destroy_r(handle, WKTWriter);
    
    return self;    
}

- (void) dealloc
{
    [geomType release];
    [wktGeom release];
    GEOSGeom_destroy_r(handle, geosGeom);
    finishGEOS_r(handle);
    [super dealloc];
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
//	exit(1);
}

@end

#pragma mark -

@implementation ShapeKitPoint
@synthesize geometry,numberOfCoords;

-(id)initWithWKT:(NSString *) wkt {
    [super initWithWKT:wkt];
    GEOSCoordSequence *sequence = GEOSCoordSeq_clone_r(handle, GEOSGeom_getCoordSeq(geosGeom));
    geometry = [[MKPointAnnotation alloc] init];
    double xCoord;
    GEOSCoordSeq_getX_r(handle, sequence, 0, &xCoord);
    
    double yCoord;
    GEOSCoordSeq_getY_r(handle, sequence, 0, &yCoord);
    geometry.coordinate = CLLocationCoordinate2DMake(yCoord, xCoord);
    
    GEOSCoordSeq_getSize_r(handle, sequence, &numberOfCoords);
    GEOSCoordSeq_destroy_r(handle, sequence);
        
    return self;
}

-(id)initWithGeosGeometry:(GEOSGeometry *)geom {
    [super initWithGeosGeometry:geom];
    GEOSCoordSequence *sequence = GEOSCoordSeq_clone_r(handle, GEOSGeom_getCoordSeq_r(handle, geosGeom));
    geometry = [[MKPointAnnotation alloc] init];
    double xCoord;
    GEOSCoordSeq_getX_r(handle, sequence, 0, &xCoord);
    
    double yCoord;
    GEOSCoordSeq_getY_r(handle, sequence, 0, &yCoord);
    geometry.coordinate = CLLocationCoordinate2DMake(yCoord, xCoord);
    
    GEOSCoordSeq_getSize_r(handle, sequence, &numberOfCoords);
    GEOSCoordSeq_destroy_r(handle, sequence);
    
    return self;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D)coordinate {
    [super init];
    GEOSCoordSequence *seq = GEOSCoordSeq_create_r(handle, 1,2);
    GEOSCoordSeq_setX_r(handle, seq, coordinate.longitude, 0);
    GEOSCoordSeq_setY_r(handle, seq, coordinate.latitude, 0);
    self.geosGeom = GEOSGeom_createPoint_r(handle, seq);

    // TODO: Move the destroy into the dealloc method
    // GEOSCoordSeq_destroy(seq);
    geometry = [[MKPointAnnotation alloc] init];
    geometry.coordinate = coordinate;
    
    GEOSWKTWriter *WKTWriter = GEOSWKTWriter_create_r(handle);
    self.wktGeom = [NSString stringWithUTF8String:GEOSWKTWriter_write_r(handle, WKTWriter,geosGeom)];
    GEOSWKTWriter_destroy_r(handle, WKTWriter);
    
    return self;
}

- (void) dealloc
{
    [geometry release];
    [super dealloc];
}

@end

#pragma mark -

@implementation ShapeKitPolyline
@synthesize geometry,numberOfCoords;

-(id)initWithWKT:(NSString *) wkt {
    [super initWithWKT:wkt];
    GEOSCoordSequence *sequence = GEOSCoordSeq_clone_r(handle, GEOSGeom_getCoordSeq_r(handle, geosGeom));
    GEOSCoordSeq_getSize_r(handle, sequence, &numberOfCoords);
    CLLocationCoordinate2D coords[numberOfCoords];
    
    for (int coord = 0; coord < numberOfCoords; coord++) {
        double xCoord = NULL;
        GEOSCoordSeq_getX_r(handle, sequence, coord, &xCoord);
        
        double yCoord = NULL;
        GEOSCoordSeq_getY_r(handle, sequence, coord, &yCoord);
        coords[coord] = CLLocationCoordinate2DMake(yCoord, xCoord);
    }
    geometry = [MKPolyline polylineWithCoordinates:coords count:numberOfCoords];

    GEOSCoordSeq_destroy_r(handle, sequence);
    
    return self;
}

-(id)initWithGeosGeometry:(GEOSGeometry *)geom {
    [super initWithGeosGeometry:geom];
    GEOSCoordSequence *sequence = GEOSCoordSeq_clone_r(handle, GEOSGeom_getCoordSeq_r(handle, geosGeom));
    GEOSCoordSeq_getSize_r(handle, sequence, &numberOfCoords);
    CLLocationCoordinate2D coords[numberOfCoords];
    
    for (int coord = 0; coord < numberOfCoords; coord++) {
        double xCoord = NULL;
        GEOSCoordSeq_getX_r(handle, sequence, coord, &xCoord);
        
        double yCoord = NULL;
        GEOSCoordSeq_getY_r(handle, sequence, coord, &yCoord);
        coords[coord] = CLLocationCoordinate2DMake(yCoord, xCoord);
    }
    geometry = [MKPolyline polylineWithCoordinates:coords count:numberOfCoords];
    
    GEOSCoordSeq_destroy_r(handle, sequence);
    
    return self;
    
}

-(id)initWithCoordinates:(CLLocationCoordinate2D[])coordinates count:(unsigned int)count{
    [super init];
    GEOSCoordSequence *seq = GEOSCoordSeq_create_r(handle, count,2);
    
    for (int i = 0; i < count; i++) {
        GEOSCoordSeq_setX_r(handle, seq, i, coordinates[i].longitude);
        GEOSCoordSeq_setY_r(handle, seq, i, coordinates[i].latitude);
    }
    self.geosGeom = GEOSGeom_createLineString_r(handle, seq);
    
    // TODO: Move the destroy into the dealloc method
    // GEOSCoordSeq_destroy(seq);
    geometry = [MKPolyline polylineWithCoordinates:coordinates count:count];
    
    GEOSWKTWriter *WKTWriter = GEOSWKTWriter_create_r(handle);
    self.wktGeom = [NSString stringWithUTF8String:GEOSWKTWriter_write_r(handle, WKTWriter,geosGeom)];
    GEOSWKTWriter_destroy_r(handle, WKTWriter);
    
    return self;
}

@end

#pragma mark -

@implementation ShapeKitPolygon
@synthesize geometry,numberOfCoords;

-(id)initWithWKT:(NSString *) wkt {
    [super initWithWKT:wkt];
    GEOSCoordSequence *sequence = GEOSCoordSeq_clone_r(handle, GEOSGeom_getCoordSeq_r(handle, GEOSGetExteriorRing(geosGeom)));
    GEOSCoordSeq_getSize_r(handle, sequence, &numberOfCoords);
    CLLocationCoordinate2D coords[numberOfCoords];
    
    for (int coord = 0; coord < numberOfCoords; coord++) {
        double xCoord = NULL;
        GEOSCoordSeq_getX_r(handle, sequence, coord, &xCoord);
        
        double yCoord = NULL;
        GEOSCoordSeq_getY_r(handle, sequence, coord, &yCoord);
        coords[coord] = CLLocationCoordinate2DMake(yCoord, xCoord);
    }
    geometry = [MKPolygon polygonWithCoordinates:coords count:numberOfCoords];
    
    GEOSCoordSeq_destroy_r(handle, sequence);
    
    return self;
}

-(id)initWithGeosGeometry:(GEOSGeometry *)geom {
    [super initWithGeosGeometry:geom];
    GEOSCoordSequence *sequence = GEOSCoordSeq_clone_r(handle, GEOSGeom_getCoordSeq_r(handle, GEOSGetExteriorRing_r(handle, geosGeom)));
    GEOSCoordSeq_getSize_r(handle, sequence, &numberOfCoords);
    CLLocationCoordinate2D coords[numberOfCoords];
    
    for (int coord = 0; coord < numberOfCoords; coord++) {
        double xCoord = NULL;
        GEOSCoordSeq_getX_r(handle, sequence, coord, &xCoord);
        
        double yCoord = NULL;
        GEOSCoordSeq_getY_r(handle, sequence, coord, &yCoord);
        coords[coord] = CLLocationCoordinate2DMake(yCoord, xCoord);
    }
    geometry = [MKPolygon polygonWithCoordinates:coords count:numberOfCoords];
    
    GEOSCoordSeq_destroy_r(handle, sequence);
    
    return self;
}

-(id)initWithCoordinates:(CLLocationCoordinate2D[])coordinates count:(unsigned int)count {
    [super init];
    GEOSCoordSequence *seq = GEOSCoordSeq_create_r(handle, count,2);
    
    for (int i = 0; i < count; i++) {
        GEOSCoordSeq_setX_r(handle, seq, i, coordinates[i].longitude);
        GEOSCoordSeq_setY_r(handle, seq, i, coordinates[i].latitude);
    }
    GEOSGeometry *ring = GEOSGeom_createLinearRing_r(handle, seq);
    self.geosGeom = GEOSGeom_createPolygon_r(handle, ring, NULL, 0);
    
    // TODO: Move the destroy into the dealloc method
    // GEOSCoordSeq_destroy(seq);
    geometry = [MKPolygon polygonWithCoordinates:coordinates count:count];
    
    GEOSWKTWriter *WKTWriter = GEOSWKTWriter_create_r(handle);
    self.wktGeom = [NSString stringWithUTF8String:GEOSWKTWriter_write_r(handle, WKTWriter,geosGeom)];
    GEOSWKTWriter_destroy_r(handle, WKTWriter);
    
    return self;
    
}

@end