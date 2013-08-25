//
//  YYRoomListRequest.m
//  AppInfoIphone
//
//  Created by kuxing on 13-8-23.
//  Copyright (c) 2013年 kuxing. All rights reserved.
//

#import "YYRoomListRequest.h"

@implementation YYRoomListRequest
static NSString *kFAVORITE_REQUEST = @"/roomlist";
+(id)requestWithUID:(NSNumber *)uid
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", [DataManager shareManager].kServerURL,kFAVORITE_REQUEST];
    NSURL *url = [NSURL URLWithString:urlString];
    id request = [self requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setShouldRedirect:NO];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    [request setPostValue:uid forKey:@"uid"];
   
    return request;
}
- (void)processResponse
{
    RoomListEntity *entity = [[RoomListEntity alloc] init];
    RoomListEntity *info = [self parseJson:entity];
    if (info) {
        info.Results = info.responseInfo[@"Results"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:KXRoomListNotification object:info];
    }

}
@end
