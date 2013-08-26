//
//  KXResponseBaseEntity.m
//  KXShow
//
//  Created by 杨亚楠 on 12-12-5.
//  Copyright (c) 2012年 guoxj. All rights reserved.
//

#import "HttpResponseBaseEntity.h"

@implementation HttpResponseBaseEntity
- (id)init
{
    self = [super init];
    if (self) {
        self.ResultMsg = @"";
        self.resultCode = -1000;
    }
    return self;
}

@end
