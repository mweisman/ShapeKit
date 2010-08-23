//
//  GeoKitViewController.m
//  GeoKit
//
//  Created by Michael Weisman on 10-08-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GeoKitViewController.h"
#import "GeoKitGeometry.h"

@implementation GeoKitViewController
@synthesize theMap;



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create a point geometry and put it on the map
    GeoKitPoint *myPoint = [[GeoKitPoint alloc] initWithWKT:@"POINT(0 0)"];
    myPoint.geometry.title = @"0 0";
    myPoint.geometry.subtitle = @"Next to the most awesome place in the world";
    [theMap addAnnotation:myPoint.geometry];
    
    // Create a polygon and see if it contains the point
    GeoKitGeometry *polygon = [[GeoKitGeometry alloc] initWithWKT:@"POLYGON((-1 -1, -1 1, 1 1, 1 -1, -1 -1))"];
    if ([polygon contains:myPoint]) {
        NSLog(@"Contains");
    } else {
        NSLog(@"NO");
    }

    [myPoint release];
    [polygon release];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
