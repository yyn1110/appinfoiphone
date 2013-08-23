//
//  UIViewController+Utils.h
//  KXShow
//
//  Created by xj guo on 11-11-18.
//  Copyright (c) 2011年 kuxing.com. All rights reserved.
//

@interface UIViewController (Utils)
- (void)setTitle:(NSString*)title custom:(BOOL)custom;
- (void)setParentContainerViewController:(UIViewController *)vc;
- (UIViewController *)parentContainerViewController;
@end
