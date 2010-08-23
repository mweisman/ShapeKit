//
//  GeoKitAppDelegate.h
//  GeoKit
//
//  Created by Michael Weisman on 10-08-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GeoKitViewController;

@interface GeoKitAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    GeoKitViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet GeoKitViewController *viewController;

@end

