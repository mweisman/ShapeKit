//
//  ShapeKitAppDelegate.h
//  ShapeKit
//
//  Created by Michael Weisman on 10-08-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShapeKitViewController;

@interface ShapeKitAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ShapeKitViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ShapeKitViewController *viewController;

@end

