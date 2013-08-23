//
//  YYLeftViewController.h
//  AppInfoIphone
//
//  Created by kuxing on 13-8-23.
//  Copyright (c) 2013年 kuxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYBangViewController.h"
#import "YYBestViewController.h"

extern NSString * const kViewController;
extern NSString * const kViewControllerTitle;
@protocol YYLeftViewControllerDelegate;
@interface YYLeftViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,assign) id<YYLeftViewControllerDelegate> delegate;
@property (nonatomic,strong) NSMutableArray *dataSource;
@end
@protocol YYLeftViewControllerDelegate <NSObject>
- (void)YYLeftViewController:(YYLeftViewController *)left didSelectIndexPath:(NSIndexPath *)path withController:(UIViewController *)controller;
@end
