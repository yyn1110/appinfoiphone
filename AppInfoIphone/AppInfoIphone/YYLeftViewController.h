//
//  YYLeftViewController.h
//  AppInfoIphone
//
//  Created by kuxing on 13-8-23.
//  Copyright (c) 2013年 kuxing. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YYLeftViewControllerDelegate;
@interface YYLeftViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,assign) id<YYLeftViewControllerDelegate> delegate;
@end
@protocol YYLeftViewControllerDelegate <NSObject>
- (void)YYLeftViewController:(YYLeftViewController *)left didSelectIndexPath:(NSIndexPath *)path;
@end
