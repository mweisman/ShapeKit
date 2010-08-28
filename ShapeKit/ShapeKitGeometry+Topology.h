//
//  ShapeKitGeometry+Topology.h
//  ShapeKit
//
//  Created by Michael Weisman on 10-08-26.
// * This is free software; you can redistribute and/or modify it under
// the terms of the GNU Lesser General Public Licence as published
// by the Free Software Foundation. 
// See the COPYING file for more information.
//

#import <Foundation/Foundation.h>
#import "ShapeKitGeometry.h"


@interface ShapeKitGeometry (Topology)

-(ShapeKitPolygon *)envelope;
-(ShapeKitPolygon *)bufferWithWidth:(double)width;
-(ShapeKitPolygon *)convexHull;
-(NSString *)relationshipWithGeometry:(ShapeKitGeometry *)geometry;
-(ShapeKitPoint *)centroid;
-(ShapeKitPoint *)pointOnSurface;

// TODO require adding multigeom support ShapeKitGeometry
//-(ShapeKitPolygon *)intersectionWithGeometry:(ShapeKitGeometry *)geometry;
//-(ShapeKitPolygon *)differenceWithGeometry:(ShapeKitGeometry *)geometry;
//-(ShapeKitPolygon *)boundary;
//-(ShapeKitPolygon *)unionWithGeometry:(ShapeKitGeometry *)geometry;
//-(ShapeKitPolygon *)cascadedUnion;



@end
