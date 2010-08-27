//
//  ShapeKitGeometry+Topology.h
//  ShapeKit
//
//  Created by Michael Weisman on 10-08-26.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
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
