//
//  DataManager.h
//  AppInfoIphone
//
//  Created by yangyanan on 13-8-24.
//  Copyright (c) 2013年 kuxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject
+(DataManager *)shareManager;
@property (nonatomic,strong) NSString *kServerURL;
@end
