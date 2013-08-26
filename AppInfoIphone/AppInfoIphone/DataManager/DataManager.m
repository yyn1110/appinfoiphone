//
//  DataManager.m
//  AppInfoIphone
//
//  Created by yangyanan on 13-8-24.
//  Copyright (c) 2013年 kuxing. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager
static DataManager *manager;
+(DataManager *)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DataManager alloc] init];
    });

    return manager;
}
- (id)init
{
    self = [super init];
    if (self) {
        self.kServerURL = @"http://192.168.20.106:8080";
    }
    return self;
}
@end
