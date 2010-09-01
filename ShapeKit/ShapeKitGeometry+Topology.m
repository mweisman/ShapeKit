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
//    return [[[ShapeKitPolygon alloc] initWithGeosGeometry:GEOSEnvelope_r(handle, geosGeom) GEOSContextHandle:ghandle] autorelease];
    return [[[ShapeKitPolygon alloc] initWithGeosGeometry:GEOSEnvelope_r(handle, geosGeom)] autorelease];
}

-(ShapeKitPolygon *)bufferWithWidth:(double)width {
    return [[[ShapeKitPolygon alloc] initWithGeosGeometry:GEOSBuffer_r(handle, geosGeom, width, 0)] autorelease];
}

-(ShapeKitPolygon *)convexHull {
    return [[[ShapeKitPolygon alloc] initWithGeosGeometry:GEOSConvexHull_r(handle, geosGeom)] autorelease];
}

-(NSString *)relationshipWithGeometry:(ShapeKitGeometry *)geometry {
    return [NSString stringWithUTF8String:GEOSRelate_r(handle, geosGeom, geometry.geosGeom)];
}

-(ShapeKitPoint *)centroid {
    return [[[ShapeKitPoint alloc] initWithGeosGeometry:GEOSGetCentroid_r(handle, geosGeom)] autorelease];
}

-(ShapeKitPoint *)pointOnSurface {
    return [[[ShapeKitPoint alloc] initWithGeosGeometry:GEOSPointOnSurface_r(handle, geosGeom)] autorelease];
}

@end
