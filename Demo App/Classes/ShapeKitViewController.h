//
//  ShapeKitViewController.h
//  ShapeKit
//
//  Created by Michael Weisman on 10-08-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ShapeKitViewController : UIViewController <MKMapViewDelegate> {
    IBOutlet MKMapView *theMap;
}

@property (nonatomic,retain) IBOutlet MKMapView *theMap;

@end

