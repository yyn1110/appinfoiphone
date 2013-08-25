//
//  YYRoomListRequest.h
//  AppInfoIphone
//
//  Created by kuxing on 13-8-23.
//  Copyright (c) 2013年 kuxing. All rights reserved.
//

#import "KXBaseFormDataRequest.h"
#import "RoomListEntity.h"
@interface YYRoomListRequest : KXBaseFormDataRequest
+(id)requestWithUID:(NSNumber *)uid;
@end
