//
//  UINavigationBar+Utils.m
//  KXShow
//
//  Created by xj guo on 11-11-18.
//  Copyright (c) 2011年 kuxing.com. All rights reserved.
//

#import "UINavigationBar+Utils.h"

@implementation UINavigationBar (CustomImage)  
- (void)drawRect:(CGRect)rect 
{
    UIImage *image = [UIImage imageNamed:@"global_titlebar_bg"];
    [image drawInRect:rect];
}
@end