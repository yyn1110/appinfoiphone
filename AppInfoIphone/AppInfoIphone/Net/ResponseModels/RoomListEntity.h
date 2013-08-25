//
//  RoomListEntity.h
//  AppInfoIphone
//
//  Created by yangyanan on 13-8-24.
//  Copyright (c) 2013年 kuxing. All rights reserved.
//

#import "HttpResponseBaseEntity.h"

@interface RoomListEntity : HttpResponseBaseEntity
@property (nonatomic,strong) NSDictionary *Results;
@end
