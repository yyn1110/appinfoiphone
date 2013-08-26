//
//  RoomListEntity.h
//  AppInfoIphone
//
//  Created by yangyanan on 13-8-24.
//  Copyright (c) 2013年 kuxing. All rights reserved.
//

#import "HttpResponseBaseEntity.h"
@interface BookInfoEntity : NSObject
@property (nonatomic,strong) NSNumber *BookID;
@property (nonatomic,strong) NSString *BookIntr;
@property (nonatomic,strong) NSString *BookName;
@end
@interface RoomListEntity : HttpResponseBaseEntity
@property (nonatomic,strong) NSDictionary *Results;
@end
