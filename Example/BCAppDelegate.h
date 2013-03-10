//
//  BCAppDelegate.h
//  Example
//
//  Created by Miha Rataj on 28.1.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BCNavigationViewController;

@interface BCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) BCNavigationViewController *viewController;

@end
