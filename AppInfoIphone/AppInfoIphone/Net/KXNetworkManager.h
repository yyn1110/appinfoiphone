//
//  KXNetworkManager.h
//  KXShow
//
//  Created by User on 12-11-16.
//  Copyright (c) 2012年 guoxj. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASINetworkQueue;
@class KXBaseEntity;
#import "KXNotifications.h"
#import "KXBaseRequest.h"

@interface KXNetworkManager : NSObject

+ (KXNetworkManager *)sharedKXNetworkManager;


@end
