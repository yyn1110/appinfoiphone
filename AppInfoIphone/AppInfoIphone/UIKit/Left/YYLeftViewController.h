//
//  YYLeftViewController.h
//  AppInfoIphone
//
//  Created by kuxing on 13-8-23.
//  Copyright (c) 2013年 kuxing. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "KXNetworkManager.h"
#import <QuartzCore/QuartzCore.h>
#import "YYLeftViewCell.h"
extern NSString * const kViewController;
extern NSString * const kViewControllerTitle;
@protocol YYLeftViewControllerDelegate;
@interface YYLeftViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,assign) id<YYLeftViewControllerDelegate> delegate;
@property (nonatomic,strong) NSDictionary *dataSource;
@end
@protocol YYLeftViewControllerDelegate <NSObject>
- (void)YYLeftViewController:(YYLeftViewController *)left didSelectIndexPath:(NSIndexPath *)path;
@end
