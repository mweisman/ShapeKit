//
//  ShapeKitGeometry+Predicates.h
//  ShapeKit

// * This is free software; you can redistribute and/or modify it under
// the terms of the GNU Lesser General Public Licence as published
// by the Free Software Foundation. 
// See the COPYING file for more information.
//

#import <Foundation/Foundation.h>
#import "ShapeKitGeometry.h"

@interface ShapeKitGeometry (predicates)

-(BOOL)isDisjointFromGeometry:(ShapeKitGeometry *)compareGeometry;
-(BOOL)touchesGeometry:(ShapeKitGeometry *)compareGeometry;
-(BOOL)intersectsGeometry:(ShapeKitGeometry *)compareGeometry;
-(BOOL)crossesGeometry:(ShapeKitGeometry *)compareGeometry;
-(BOOL)isWithinGeometry:(ShapeKitGeometry *)compareGeometry;
-(BOOL)containsGeometry:(ShapeKitGeometry *)compareGeometry;
-(BOOL)overlapsGeometry:(ShapeKitGeometry *)compareGeometry;
-(BOOL)isEqualToGeometry:(ShapeKitGeometry *)compareGeometry;
-(BOOL)isRelatedToGeometry:(ShapeKitGeometry *)compareGeometry WithRelatePattern:(NSString *)pattern;

@end
