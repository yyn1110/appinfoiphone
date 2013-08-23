//
//  YYAppDelegate.h
//  AppInfoIphone
//
//  Created by kuxing on 13-8-23.
//  Copyright (c) 2013年 kuxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYLeftViewController.h"
#import "YYRightViewController.h"

#import "MMDrawerController.h"

@interface YYAppDelegate : UIResponder <UIApplicationDelegate,YYLeftViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MMDrawerController *drawerController;


@end
