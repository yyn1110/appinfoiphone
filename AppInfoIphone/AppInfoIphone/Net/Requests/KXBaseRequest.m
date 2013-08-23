//
//  KXBaseRequest.m
//  KXShow
//
//  Created by User on 12-11-16.
//  Copyright (c) 2012年 guoxj. All rights reserved.
//

#import "KXBaseRequest.h"

@implementation KXBaseRequest

- (id)initWithURL:(NSURL *)newURL
{
    self = [super initWithURL:newURL];
    if (self) {
        [self setShouldRedirect:NO];
        [self setDefaultResponseEncoding:NSUTF8StringEncoding];
        [self setTimeOutSeconds:10];
        [self addRequestHeader:@"Accept" value:@"text/json"];
    }
    return self;
}
@end
