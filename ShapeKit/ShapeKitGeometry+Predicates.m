//
//  ShapeKitGeometry+Predicates.m
//  ShapeKit

// * This is free software; you can redistribute and/or modify it under
// the terms of the GNU Lesser General Public Licence as published
// by the Free Software Foundation. 
// See the COPYING file for more information.
//

#import "ShapeKitGeometry+Predicates.h"


@implementation ShapeKitGeometry (predicates)

-(BOOL)isDisjointFromGeometry:(ShapeKitGeometry *)compareGeometry {
    BOOL disjoint = GEOSDisjoint(geosGeom, compareGeometry.geosGeom);
    return disjoint;
}

-(BOOL)touchesGeometry:(ShapeKitGeometry *)compareGeometry {
    BOOL touches = GEOSTouches(geosGeom, compareGeometry.geosGeom);
    return touches;
}

-(BOOL)intersectsGeometry:(ShapeKitGeometry *)compareGeometry {
    BOOL intersects = GEOSIntersects(geosGeom, compareGeometry.geosGeom);
    return intersects;
}

-(BOOL)crossesGeometry:(ShapeKitGeometry *)compareGeometry {
    BOOL crosses = GEOSCrosses(geosGeom, compareGeometry.geosGeom);
    return crosses;
}

-(BOOL)isWithinGeometry:(ShapeKitGeometry *)compareGeometry {
    BOOL within = GEOSWithin(geosGeom, compareGeometry.geosGeom);
    return within;
}

-(BOOL)containsGeometry:(ShapeKitGeometry *)compareGeometry {
    BOOL contains = GEOSContains(geosGeom, compareGeometry.geosGeom);
    return contains;
}

-(BOOL)overlapsGeometry:(ShapeKitGeometry *)compareGeometry {
    BOOL overlaps = GEOSOverlaps(geosGeom, compareGeometry.geosGeom);
    return overlaps;
}

-(BOOL)isEqualToGeometry:(ShapeKitGeometry *)compareGeometry {
    BOOL equals = GEOSEquals(geosGeom, compareGeometry.geosGeom);
    return equals;
}


-(BOOL)isRelatedToGeometry:(ShapeKitGeometry *)compareGeometry WithRelatePattern:(NSString *)pattern {
    BOOL patt_success = GEOSRelatePattern(geosGeom, compareGeometry.geosGeom, [pattern UTF8String]);
    return patt_success;
}

@end
