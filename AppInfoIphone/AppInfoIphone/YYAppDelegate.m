//
//  YYAppDelegate.m
//  AppInfoIphone
//
//  Created by kuxing on 13-8-23.
//  Copyright (c) 2013年 kuxing. All rights reserved.
//

#import "YYAppDelegate.h"

@implementation YYAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    YYLeftViewController *left = [[YYLeftViewController alloc] init];
    left.delegate = self;
    UINavigationController *leftNav = [[UINavigationController alloc] initWithRootViewController:left];
    YYRightViewController *right = [[YYRightViewController alloc] init];
    UINavigationController *rightNav = [[UINavigationController alloc] initWithRootViewController:right];
    YYBestViewController *best = [[YYBestViewController alloc] init];
    best.title = @"精品推荐";
    UINavigationController *bestNav = [[UINavigationController alloc] initWithRootViewController:best];

    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:bestNav leftDrawerViewController:leftNav rightDrawerViewController:rightNav];
    self.drawerController.showsShadow = YES;
    self.drawerController.shouldStretchDrawer = NO;
    [self.drawerController setMaximumLeftDrawerWidth:150];
    [self.drawerController setMaximumRightDrawerWidth:150.0];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
   
    self.window.rootViewController = self.drawerController;

    
    
    return YES;
}

- (void)YYLeftViewController:(YYLeftViewController *)left didSelectIndexPath:(NSIndexPath *)path;
{

    [self.drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        
    }];
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
