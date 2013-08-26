//
//  YYCheckUpdateRequest.m
//  AppInfoIphone
//
//  Created by kuxing on 13-8-26.
//  Copyright (c) 2013年 kuxing. All rights reserved.
//

#import "YYCheckUpdateRequest.h"
static NSString *kCHECK_REQUEST = @"/checkupdate";
@implementation YYCheckUpdateRequest
+(id)requestCheckUpdate
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", [DataManager shareManager].kServerURL,kCHECK_REQUEST];
    NSURL *url = [NSURL URLWithString:urlString];
    YYCheckUpdateRequest *request = [self requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setShouldRedirect:NO];
    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    for (int i=0; i<[request.deviceInfo allKeys].count; i++) {
        NSArray *allkeys= [request.deviceInfo allKeys];
        NSString *key = allkeys[i];
        [request setPostValue:request.deviceInfo[key]  forKey:key];
    }
    
    return request;
}
- (void)processResponse
{
    CheckUpdateEntity *entity = [[CheckUpdateEntity alloc] init];
    CheckUpdateEntity *info = [self parseJson:entity];
    if (info) {
    //    info.Results = info.responseInfo[@"Results"];
        NSDictionary *Results = info.responseInfo[@"Results"];
        DLog(@"====%@",Results);
        NSDictionary *data = Results[@"data"];
        DLog(@"data====%@",data);
        info.isUpdate = data[@"IsUpdate"];
        info.msg = data[@"Msg"];
        [[NSNotificationCenter defaultCenter] postNotificationName:KXCheckUpdateNotification object:info];
    }
    
}
@end
