//
//  ShapeKitGeometry+Topology.m
//  ShapeKit
//
//  Created by Michael Weisman on 10-08-26.
// * This is free software; you can redistribute and/or modify it under
// the terms of the GNU Lesser General Public Licence as published
// by the Free Software Foundation. 
// See the COPYING file for more information.
//
#import "ShapeKitGeometry+Topology.h"


@implementation ShapeKitGeometry (Topology)

-(ShapeKitPolygon *)envelope {
    return [[[ShapeKitPolygon alloc] initWithGeosGeometry:GEOSEnvelope(geosGeom)] autorelease];
}

-(ShapeKitPolygon *)bufferWithWidth:(double)width {
    return [[[ShapeKitPolygon alloc] initWithGeosGeometry:GEOSBuffer(geosGeom, width, 0)] autorelease];
}

-(ShapeKitPolygon *)convexHull {
    return [[[ShapeKitPolygon alloc] initWithGeosGeometry:GEOSConvexHull(geosGeom)] autorelease];
}

-(NSString *)relationshipWithGeometry:(ShapeKitGeometry *)geometry {
    return [NSString stringWithUTF8String:GEOSRelate(geosGeom, geometry.geosGeom)];
}

-(ShapeKitPoint *)centroid {
    return [[[ShapeKitPoint alloc] initWithGeosGeometry:GEOSGetCentroid(geosGeom)] autorelease];
}

-(ShapeKitPoint *)pointOnSurface {
    return [[[ShapeKitPoint alloc] initWithGeosGeometry:GEOSPointOnSurface(geosGeom)] autorelease];
}

@end
