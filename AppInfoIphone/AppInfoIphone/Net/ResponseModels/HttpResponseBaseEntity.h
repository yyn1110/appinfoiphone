//
//  KXResponseBaseEntity.h
//  KXShow
//
//  Created by 杨亚楠 on 12-12-5.
//  Copyright (c) 2012年 guoxj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpResponseBaseEntity : NSObject
@property (nonatomic,retain) NSString *msg;
@property (nonatomic,assign) int resultCode;
@end
