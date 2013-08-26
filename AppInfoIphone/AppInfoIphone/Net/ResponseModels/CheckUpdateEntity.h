//
//  CheckUpdateEntity.h
//  AppInfoIphone
//
//  Created by kuxing on 13-8-26.
//  Copyright (c) 2013年 kuxing. All rights reserved.
//

#import "HttpResponseBaseEntity.h"

@interface CheckUpdateEntity : HttpResponseBaseEntity
@property (nonatomic,strong) NSNumber *isUpdate;
@property (nonatomic,strong) NSString *msg;
@end
