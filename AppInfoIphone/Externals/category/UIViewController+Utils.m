//
//  UIViewController+Utils.m
//  KXShow
//
//  Created by xj guo on 11-11-18.
//  Copyright (c) 2011年 kuxing.com. All rights reserved.
//

#import "UIViewController+Utils.h"
#import <objc/runtime.h>

static void * const kMyAssociatedStorageKey = (void*)&kMyAssociatedStorageKey;

@implementation UIViewController (Utils)
- (void)setTitle:(NSString*)title custom:(BOOL)custom
{
    if (custom) {
        CGRect frame = CGRectMake(0, 0, 320, 44);
        UILabel *label = [[[UILabel alloc] initWithFrame:frame] autorelease];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:20.0];
        //label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        label.textAlignment = ([self.title length] < 10 ? UITextAlignmentCenter : UITextAlignmentLeft);
        label.textColor = [UIColor whiteColor];
        label.text = title;
        [label sizeToFit];
        self.navigationItem.titleView = label;
    } else {
        self.title = title;
    }
}
- (void)setParentContainerViewController:(UIViewController *)vc
{
    objc_setAssociatedObject(self, &kMyAssociatedStorageKey,
                             vc,
                             OBJC_ASSOCIATION_ASSIGN);
}
- (UIViewController *)parentContainerViewController
{
    return (UIViewController *)objc_getAssociatedObject(self, kMyAssociatedStorageKey);
}
@end