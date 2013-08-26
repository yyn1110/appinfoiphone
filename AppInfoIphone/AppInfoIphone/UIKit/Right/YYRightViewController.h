//
//  YYRightViewController.h
//  AppInfoIphone
//
//  Created by kuxing on 13-8-23.
//  Copyright (c) 2013年 kuxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYRightCell.h"
#import "YYAccountController.h"
#import "YYTimeTableController.h"
#import "YYGetAnswerController.h"
#import "YYAboutController.h"
@protocol YYRightViewControllerDelegate;
@interface YYRightViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,weak) id<YYRightViewControllerDelegate> delegate;
@end
@protocol YYRightViewControllerDelegate <NSObject>

- (void)YYRightViewController:(YYRightViewController *)YYRightViewController didSelectIndexPath:(NSIndexPath *)indexPath withController:(UIViewController *)controller;

@end