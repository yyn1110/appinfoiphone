//
//  KXBaseFormDataRequest.h
//  KXShow
//
//  Created by User on 12-11-16.
//  Copyright (c) 2012年 guoxj. All rights reserved.
//

#import "ASIFormDataRequest.h"
#import "HttpResponseBaseEntity.h"
#import "Reachability.h"
#import "JSONKit.h"
#import "UIDevice-Hardware.h"
#import "KXNotifications.h"
@interface KXBaseFormDataRequest : ASIFormDataRequest
@property (nonatomic,retain) HttpResponseBaseEntity *errorInfo;
@property (nonatomic,strong) NSMutableDictionary *deviceInfo;

- (id)parseJson;
@end
